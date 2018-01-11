//
//  AppUser.m
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/29.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#import "AppUser.h"

#define DefaultUserKey @"DefaultUserKey"

#pragma mark -
@implementation AppUser

#pragma mark - sharedUser
+ (instancetype)sharedUser
{
    static AppUser *_sharedUser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSData *data = [UserDefaults objectForKey:DefaultUserKey];
        if (data)
        {
            _sharedUser = [NSKeyedUnarchiver unarchiveObjectWithData:data
                                                           exception:NULL];
        }
        else
        {
            _sharedUser = [self new];
            [_sharedUser setPorpertyToDefaultValue];
        }
    });
    return _sharedUser;
}

#pragma mark - 各属性设置为默认值
- (void)setPorpertyToDefaultValue
{
    self.isLogin = NO;
}

#pragma mark - 登录
+ (void)setLoginWithDic:(NSDictionary *)dic
{
    // 设置用户属性
    [kUser modelSetWithDictionary:dic];
    
    // 修改登录状态
    kUser.isLogin = YES;
    
    // 同步
    [kUser synchro];
}

#pragma mark - 退出
+ (void)logout
{
    // 各属性设置为默认值
    [kUser setPorpertyToDefaultValue];
    
    // 同步
    [kUser synchro];
}

#pragma mark - 更新用户信息
- (void)updateUserInfo
{
    
}

#pragma mark - 同步到缓存
- (void)synchro
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [UserDefaults setObject:data forKey:DefaultUserKey];
    [UserDefaults synchronize];
}

@end
