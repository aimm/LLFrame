//
//  UIButton+Theme.m
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/4.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import "UIButton+Theme.h"
#import "AppTheme.h"

@implementation UIButton (Theme)

- (void)setToCurrentTheme
{
    // Normal background image
    UIImage *normalBgImage = [kTheme buttonNormalBackgroundImage];
    [self setBackgroundImage:normalBgImage forState:UIControlStateNormal];
    
    // Disabled background image
    UIImage *disabledBgImage = [kTheme buttonDisabledBackgroundImage];
    [self setBackgroundImage:disabledBgImage forState:UIControlStateDisabled];
    
    // Normal title color
    UIColor *normalTitleColor = [kTheme buttonNormalTitleColor];
    [self setTitleColor:normalTitleColor forState:UIControlStateNormal];
    
    // Disabled title color
    UIColor *disabledTitleColor = [kTheme buttonDisabledTitleColor];
    [self setTitleColor:disabledTitleColor forState:UIControlStateDisabled];
    
    // Corner radius
    self.layer.cornerRadius = [kTheme buttonCornerRadius];
    self.layer.masksToBounds = YES;
}

@end
