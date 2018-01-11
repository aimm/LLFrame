//
//  AppDelegate.m
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/19.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#import "AppDelegate.h"
#import "AppBuilder.h"
// 主选项卡
#import "MainTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 试试
    [AppBuilder build];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [MainTabBarController mainTabBarController];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
