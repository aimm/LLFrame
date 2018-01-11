//
//  AppThemeProtocol.h
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/4.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AppThemeProtocol <NSObject>

/* Theme color */
- (UIColor *)themeColor;

/* Button */
- (CGFloat)buttonCornerRadius;
- (UIImage *)buttonNormalBackgroundImage;
- (UIImage *)buttonDisabledBackgroundImage;
- (UIColor *)buttonNormalTitleColor;
- (UIColor *)buttonDisabledTitleColor;

@end
