//
//  LoginVC.m
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/29.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"登录";
    
    // 取消登录
    UIBarButtonItem *cancelLoginItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:14 target:self action:@selector(cancelLogin)];
    self.navigationItem.leftBarButtonItem = cancelLoginItem;
    
}

// 取消登录
- (void)cancelLogin
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    [self setLoginSuccessBlock:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
