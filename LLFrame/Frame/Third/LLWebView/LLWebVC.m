//
//  LLWebVC.m
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/1.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import "LLWebVC.h"
#import "SysAlertHelper.h"

@interface LLWebVC ()

@property (nonatomic,copy) NSString *webTitle;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,assign) BOOL prefersNavBarHidden;

@property (nonatomic,strong) UIProgressView *progressView;
@property (nonatomic,strong) NJKWebViewProgress *progressProxy;

@end

@implementation LLWebVC

- (instancetype)initWithWebType:(LLWebType)type
                       webTitle:(NSString *)webtTitle
                            url:(NSString *)url
            prefersNavBarHidden:(BOOL)prefersNavBarHidden;
{
    self = [super init];
    if (self)
    {
        self.type = type;
        self.webTitle = webtTitle;
        self.url = url;
        self.prefersNavBarHidden = prefersNavBarHidden;
        if (self.prefersNavBarHidden == NO)
        {
            self.navigationItem.title = self.webTitle;
        }
        
        NSURL *url = [NSURL URLWithString:self.url];
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        
        if (self.type == LLWebTypeWKWebView)
        {
            [self.view addSubview:self.wkWebView];
            [self.view addSubview:self.progressView];
            
            [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
            
            [self.wkWebView loadRequest:req];
        }
        else if (self.type == LLWebTypeUIWebView)
        {
            [self.view addSubview:self.norWebView];
            [self.view addSubview:self.progressView];
            
            [self.norWebView loadRequest:req];
        }
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqual: @"estimatedProgress"])
    {
        [self setProgress:self.wkWebView.estimatedProgress];
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [self setProgress:progress];
}

- (void)setProgress:(float)progress
{
    [self.progressView setAlpha:1.0f];
    [self.progressView setProgress:progress animated:YES];
    if(progress >= 1.0f)
    {
        [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.progressView setAlpha:0.0f];
        } completion:^(BOOL finished) {
            [self.progressView setProgress:0.0f animated:NO];
        }];
    }
}

#pragma mark - 下面3个方法处理WK网页里弹出框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    [SysAlertHelper showSystemAlertInVC:self title:@"提示" message:message?:@"" cancelBtnTitle:@"确定" cancelBtnClickedBlock:^{
        completionHandler();
    }];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler
{
    [SysAlertHelper showSystemAlertInVC:self title:@"提示" message:message?:@"" cancelBtnTitle:@"取消" cancelBtnClickedBlock:^{
        completionHandler(NO);
    } okBtnTitle:@"确认" okBtnClicekdBlock:^{
        completionHandler(YES);
    }];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 懒加载
- (WKWebView *)wkWebView
{
    if (!_wkWebView)
    {
        CGFloat y = self.prefersNavBarHidden ? 0 : kTopHeight;
        _wkWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, y, kScreenWidth, kScreenHeight - kTopHeight)];
        _wkWebView.UIDelegate = self;
        _wkWebView.navigationDelegate = self;
        [self.view addSubview:_wkWebView];
    }
    return _wkWebView;
}

- (UIWebView *)norWebView
{
    if (!_norWebView)
    {
        CGFloat y = self.prefersNavBarHidden ? 0 : kTopHeight;
        _norWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, y, kScreenWidth, kScreenHeight - kTopHeight)];
        _norWebView.delegate = self.progressProxy;
    }
    return _norWebView;
}

- (UIProgressView *)progressView
{
    if (!_progressView)
    {
        CGFloat y = self.prefersNavBarHidden ? 0 : kTopHeight;
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, y, kScreenWidth,1)];
        _progressView.progressViewStyle = UIProgressViewStyleBar;
    }
    return _progressView;
}

- (NJKWebViewProgress *)progressProxy
{
    if (!_progressProxy)
    {
        _progressProxy = [[NJKWebViewProgress alloc] init];
        _progressProxy.webViewProxyDelegate = self;
        _progressProxy.progressDelegate = self;
    }
    return _progressProxy;
}

- (void)dealloc
{
    if (_wkWebView)
    {
        [_wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
