//
//  AppUser.h
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/29.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#import "RootModel.h"

/**
 当前用户
 */
@interface AppUser : RootModel

/// 是否已登录
@property (nonatomic,assign) BOOL isLogin;

/// 全局共享的当前用户
+ (instancetype)sharedUser;

/**
 登录

 @param dic 用户信息字典
 */
+ (void)setLoginWithDic:(NSDictionary *)dic;

/// 退出
+ (void)logout;

/// 更新用户信息
- (void)updateUserInfo;

/// 同步到缓存
- (void)synchro;

@end
