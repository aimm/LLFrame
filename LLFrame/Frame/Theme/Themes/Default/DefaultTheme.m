//
//  DefaultTheme.m
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/4.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import "DefaultTheme.h"

@implementation DefaultTheme

/* Theme color */
- (UIColor*)themeColor
{
    return [UIColor flatCoffeeColor];
}

/* Button */
- (CGFloat)buttonCornerRadius
{
    return AdaptedWidth(4);
}

- (UIImage *)buttonNormalBackgroundImage
{
    return [UIImage imageWithColor:[self themeColor]];
}

- (UIImage *)buttonDisabledBackgroundImage
{
    UIImage *normalBgImage = [self buttonNormalBackgroundImage];
    return [normalBgImage imageByBlurLight];
}

- (UIColor *)buttonNormalTitleColor
{
    return [UIColor whiteColor];
}

- (UIColor *)buttonDisabledTitleColor
{
    return [UIColor flatGrayColor];
}

@end
