//
//  SysAlertHelper.m
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/1.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import "SysAlertHelper.h"

@implementation SysAlertHelper

+ (void)showSystemAlertInVC:(UIViewController *)vc
                      title:(NSString *)title
                    message:(NSString *)msg
             cancelBtnTitle:(NSString *)cancelBtnTitle
      cancelBtnClickedBlock:(CancelBtnClickedBlock)cancelBlock
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelBtnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        if (cancelBlock) cancelBlock();
    }];
    [alertC addAction:cancelAction];
    
    [vc presentViewController:alertC animated:YES completion:nil];
}

+ (void)showSystemAlertInVC:(UIViewController *)vc
                      title:(NSString *)title
                    message:(NSString *)msg
             cancelBtnTitle:(NSString *)cancelBtnTitle
      cancelBtnClickedBlock:(CancelBtnClickedBlock)cancelBlock
                 okBtnTitle:(NSString *)okBtnTitle
          okBtnClicekdBlock:(OKBtnClickedBlock)okBlock
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelBtnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        if (cancelBlock) cancelBlock();
    }];
    [alertC addAction:cancelAction];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okBtnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (okBlock) okBlock();
    }];
    [alertC addAction:okAction];
    
    [vc presentViewController:alertC animated:YES completion:nil];
}

@end
