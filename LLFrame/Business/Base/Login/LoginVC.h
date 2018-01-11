//
//  LoginVC.h
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/29.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 登录成功的回调块
 主要‘想’用于实现：在某个页面需要登录，用户登录成功后自动继续刚才的操作而不用用户再次手动操作
 */
typedef void(^LoginSuccessBlock)(void);

@interface LoginVC : UIViewController

@property (nonatomic,copy) LoginSuccessBlock loginSuccessBlock;

@end
