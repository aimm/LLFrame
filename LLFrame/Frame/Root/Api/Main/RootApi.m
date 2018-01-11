//
//  RootApi.m
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/29.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#import "RootApi.h"
#import "YTKBaseRequest+AnimatingAccessory.h"

/***********************测试****************************/
#ifdef DEBUG

// 根地址
static NSString *kBaseURL = @"";

/***********************正式****************************/
#else

// 根地址
static NSString *kBaseURL = @"";

#endif

@interface RootApi ()

@end

#pragma mark -
@implementation RootApi

#pragma mark - 初始化
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        // 登录验证 - 默认否
        self.loginEnabled = LoginEnabledStrictlyNO;
        
        // 在 window 中展示请求过程的菊花
        self.animatingView = [UIApplication sharedApplication].delegate.window;
        
        // 请求中的文字提示 - 默认 空
        self.animatingText = @"";
    }
    return self;
}

- (NSString *)baseUrl
{
    return kBaseURL;
}
- (NSString *)requestUrl
{
    return @"";
}

#pragma mark - 请求方式
- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

#pragma mark - 覆写一下开始请求的方法，重新设置代理
- (void)start
{
    // 不满足条件不允许发起请求
    {
        // 1.未登录
        if (self.loginEnabled == LoginEnabledStrictlyYES)
        {
            if (kUser.isLogin == NO)
            {
                return;
            }
        }
    }
    
    // 发起请求
    [super start];
}

#pragma mark - 请求参数
/**
 1.所有请求参数均为post请求参数，防止URL拼接带来的不便
 2.高优先级参数覆盖低优先级参数，防止保留参数被覆盖
 eg:系统级参数（公共参数、签名验证参数）> 应用级参数（关键参数、登录参数）
 */
- (id)requestArgument
{
    NSMutableDictionary *argument = [NSMutableDictionary new];
    
    // 1.关键参数
    {
        if (_keyParam && _keyParam.count > 0)
        {
            [argument setValuesForKeysWithDictionary:_keyParam];
        }
    }
    
    // 2.登录验证参数
    {
        if (self.loginEnabled == LoginEnabledStrictlyYES ||
            self.loginEnabled == LoginEnabledFlexible)
        {
            
        }
    }
    
    // 3.公共参数
    {
        
    }
    
    // 4.签名验证参数
    {
        
    }
    
    return argument;
}

#pragma mark - 懒加载
- (NSMutableDictionary *)keyParam
{
    if (!_keyParam)
    {
        _keyParam = [NSMutableDictionary new];
    }
    return _keyParam;
}

@end
