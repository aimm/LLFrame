//
//  TextStyle.m
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/31.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#import "TextStyle.h"
#import "AppTheme.h"

@implementation TextStyle

+ (NSDictionary *)nameStyle
{
    return @{
             NSFontAttributeName : AdaptedFontSize(12),
             NSForegroundColorAttributeName: kTheme.themeColor
             };
}

+ (NSDictionary *)timeStyle
{
    return @{
             NSFontAttributeName : AdaptedFontSize(10),
             NSForegroundColorAttributeName: [UIColor flatGrayColor]
             };
}

+ (NSDictionary *)postStyle
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 7.0;
    
    return @{
             NSFontAttributeName : AdaptedFontSize(17),
             NSForegroundColorAttributeName: [UIColor blackColor],
             NSParagraphStyleAttributeName : paragraphStyle
             };
}

+ (NSDictionary *)longImgIndicatorStyle
{
    return @{
             NSFontAttributeName : AdaptedFontSize(17),
             NSForegroundColorAttributeName: [UIColor whiteColor]
             };
}

@end
