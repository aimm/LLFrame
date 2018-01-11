//
//  RootApi.h
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/29.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@class RootApi;

/**
 Api 是否为登录可用，即是否需要传用户登录参数
 
 - LoginEnabledStrictlyNO: 严格否，不传用户登录参数，默认值
 - LoginEnabledStrictlyYES: 严格是，必须传用户登录参数，不传无法发起请求
 - LoginEnabledFlexible: 灵活配置，根据用户当前的登录状态而定，如果登录了则传，反之不传
 */
typedef NS_ENUM(NSInteger, ApiLoginEnabled) {
    LoginEnabledStrictlyNO = 0,
    LoginEnabledStrictlyYES = 1,
    LoginEnabledFlexible = 2,
};

/**
 根Api，所有的网络请求均需要继承自本类
 NOTE:禁止保留网络请求对象
 */
@interface RootApi : YTKRequest <YTKRequestDelegate,YTKRequestAccessory>

/**
 关键参数
 NOTE:优先级最低（禁止覆盖内部保留参数）
 */
@property (nonatomic,strong) NSMutableDictionary *keyParam;

/**
 是否需要登录验证，默认 LoginEnabledStrictlyNO
 */
@property (nonatomic,assign) ApiLoginEnabled loginEnabled;

@end
