//
//  UIButton+LLAdd.h
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/1.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (LLAdd)

/**
 按钮开始倒计时
 
 @param timeout 倒计时总时长
 @param waitTitle 倒计时中的标题 eg: 传入@"a" ==> timeOutS后a
 @param endTitle 倒计时结束的标题
 */
-(void)startTime:(NSInteger )timeout
       waitTitle:(NSString *)waitTitle
        endTitle:(NSString *)endTitle;

/**
 是否正在倒计时
 */
@property (nonatomic,copy) NSString *isCountDown;

/**
 显示菊花
 */
- (void)showIndicator;

/**
 隐藏菊花
 */
- (void)hideIndicator;

@end
