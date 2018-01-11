//
//  AppBuilder.h
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/29.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * NetworkReconnectNotificationName = @"NetworkReconnectNotificationName";
static NSString * LoginStatusChangedNotificationName = @"LoginStatusChangedNotificationName";

/**
 App 构造器
 */
@interface AppBuilder : NSObject

/**
 处理App的通用配置
 */
+ (void)build;

@end
