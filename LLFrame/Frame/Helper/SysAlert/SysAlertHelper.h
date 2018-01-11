//
//  SysAlertHelper.h
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/1.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 系统提示框中，取消按钮点击的回调块
 */
typedef void(^CancelBtnClickedBlock)(void);

/**
 系统提示框中，确定按钮点击的回调块
 */
typedef void(^OKBtnClickedBlock)(void);

@interface SysAlertHelper : NSObject

+ (void)showSystemAlertInVC:(UIViewController *)vc
                      title:(NSString *)title
                    message:(NSString *)msg
             cancelBtnTitle:(NSString *)cancelBtnTitle
      cancelBtnClickedBlock:(CancelBtnClickedBlock)cancelBlock;

+ (void)showSystemAlertInVC:(UIViewController *)vc
                      title:(NSString *)title
                    message:(NSString *)msg
             cancelBtnTitle:(NSString *)cancelBtnTitle
      cancelBtnClickedBlock:(CancelBtnClickedBlock)cancelBlock
                 okBtnTitle:(NSString *)okBtnTitle
          okBtnClicekdBlock:(OKBtnClickedBlock)okBlock;

@end
