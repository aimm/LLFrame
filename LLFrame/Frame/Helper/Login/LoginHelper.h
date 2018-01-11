//
//  LoginHelper.h
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/1.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginVC.h"

@interface LoginHelper : NSObject

+ (void)showLoginFromVC:(UIViewController *)sourceVC success:(LoginSuccessBlock)success;

@end
