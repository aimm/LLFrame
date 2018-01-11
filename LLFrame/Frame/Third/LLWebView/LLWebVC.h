//
//  LLWebVC.h
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/1.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import <NJKWebViewProgress/NJKWebViewProgress.h>

/**
 网页类型枚举
 有的网页在 WKWebView 上不能使用(珍品会的幸运大转盘)，必须使用UIWebView，所以准备了2种方式
 
 - LLWebTypeWKWebView: WKWebView
 - LLWebTypeUIWebView: UIWebView
 */
typedef NS_ENUM(NSInteger, LLWebType) {
    LLWebTypeWKWebView = 0,
    LLWebTypeUIWebView = 1,
};

@interface LLWebVC : UIViewController <WKUIDelegate,WKNavigationDelegate,UIWebViewDelegate,NJKWebViewProgressDelegate>

/**
 初始化网页视图控制器，请仅使用这一种初始化方式
 
 @param type 网页类型,默认使用 WKWebView
 @param webtTitle 网页标题
 @param url 网页地址
 @param prefersNavBarHidden 是否隐藏导航栏
 @return 一个纯网页的视图控制器
 */
- (instancetype)initWithWebType:(LLWebType)type
                       webTitle:(NSString *)webtTitle
                            url:(NSString *)url
            prefersNavBarHidden:(BOOL)prefersNavBarHidden;

@property (nonatomic,assign) LLWebType type;
@property (nonatomic,strong) WKWebView *wkWebView;
@property (nonatomic,strong) UIWebView *norWebView;

@end
