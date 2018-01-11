//
//  LoginHelper.m
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/1.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import "LoginHelper.h"
#import "RootNav.h"

@implementation LoginHelper

+ (void)showLoginFromVC:(UIViewController *)sourceVC success:(LoginSuccessBlock)success
{
    LoginVC *loginVC = [LoginVC new];
    loginVC.loginSuccessBlock = success;
    RootNav *nav = [[RootNav alloc] initWithRootViewController:loginVC];
    [sourceVC presentViewController:nav animated:YES completion:nil];
}

@end
