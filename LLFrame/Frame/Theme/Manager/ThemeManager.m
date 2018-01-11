//
//  ThemeManager.m
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/4.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import "ThemeManager.h"
#import "DefaultTheme.h"

@interface ThemeManager ()

@property (nonatomic,strong) AppTheme *currentTheme;

@end

@implementation ThemeManager

+ (ThemeManager *)sharedManager
{
    static ThemeManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [self new];
        _sharedManager.currentTheme = [DefaultTheme new];
    });
    return _sharedManager;
}

+ (AppTheme *)currentTheme
{
    return [self sharedManager].currentTheme;
}

@end
