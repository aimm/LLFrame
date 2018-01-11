//
//  AppBuilder.m
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/29.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#import "AppBuilder.h"

// 键盘管理工具
#import <IQKeyboardManager/IQKeyboardManager.h>

// AppDelegate
#import "AppDelegate.h"

// 网络状态监听
#import "AFHTTPSessionManager.h"
#import <RMessage/RMessage.h>

// 主题
#import "AppTheme.h"

#pragma mark -
@implementation AppBuilder

+ (instancetype)builder
{
    static AppBuilder *_builder = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _builder = [AppBuilder new];
    });
    return _builder;
}

#pragma mark - 构建App
+ (void)build
{
    // 配置键盘管理器
    [self configKeyBoardManager];
    
    // 配置 HUD，负责信息反馈
    [self configHUD];
    
    // 网络监测
    [self observeNetworkStatus];
    
    // 登录状态监测
    [self observeLoginStatus];
    
    // Other config
    [self others];
}

#pragma mark - 配置键盘管理器
+ (void)configKeyBoardManager
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.toolbarTintColor = kTheme.themeColor;
    
    //注册 YYTextView
    [manager registerTextFieldViewClass:[YYTextView class]
        didBeginEditingNotificationName:YYTextViewTextDidBeginEditingNotification
          didEndEditingNotificationName:YYTextViewTextDidEndEditingNotification];
}

#pragma mark - 配置 HUD，负责无交互的信息反馈
+ (void)configHUD
{
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setFont:AdaptedFontSize(12)];
    [SVProgressHUD setBackgroundColor:[UIColor flatWhiteColor]];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    [SVProgressHUD setMaximumDismissTimeInterval:30];
    [SVProgressHUD setMinimumSize:CGSizeMake(AdaptedWidth(64), AdaptedWidth(64))];
}

#pragma mark - 监听网络状态
+ (void)observeNetworkStatus
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    
    RACSignal *signal = [manager rac_valuesAndChangesForKeyPath:@"networkReachabilityStatus" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld observer:[self builder]];
    [signal subscribeNext:^(RACTwoTuple *change){
        
        NSDictionary *dic = change.second;
        AFNetworkReachabilityStatus new_status = [dic[@"new"] integerValue];
        AFNetworkReachabilityStatus old_status = [dic[@"old"] integerValue];
        
        if (new_status == AFNetworkReachabilityStatusNotReachable)
        {
            UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
            [RMessage showNotificationInViewController:rootViewController
                                                 title:nil
                                              subtitle:@"网络不给力，请检查您的网络设置!"
                                                  type:RMessageTypeError
                                        customTypeName:nil
                                              duration:3
                                              callback:nil
                                  canBeDismissedByUser:YES];
        }
        else
        {
            // 断网 -> 有网
            if (old_status == AFNetworkReachabilityStatusNotReachable &&
                old_status != new_status)
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:NetworkReconnectNotificationName object:nil];
            }
        }
    }];
}

#pragma mark - 监听登录状态
+ (void)observeLoginStatus
{
    RACSignal *signal = [kUser rac_valuesAndChangesForKeyPath:@"isLogin" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld observer:[self builder]];
    [signal subscribeNext:^(RACTwoTuple *change){
        
        NSDictionary *dic = change.second;
        BOOL new_status = [dic[@"new"] integerValue];
        BOOL old_status = [dic[@"old"] integerValue];
        if (old_status != new_status)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:LoginStatusChangedNotificationName object:nil];
        }
    }];
}

#pragma mark - 其他一些零碎的配置
+ (void)others
{
    // 有时候一些图片无法下载，这里需要设置一下
    NSMutableDictionary *header = [YYWebImageManager sharedManager].headers.mutableCopy;
    header[@"User-Agent"] = @"iPhone";
    [YYWebImageManager sharedManager].headers = header;
    
    // 对UIScrollView及其子类统一处理列表偏移，需单独设置的覆盖即可
    if (@available(iOS 11.0, *))
    {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
}

@end
