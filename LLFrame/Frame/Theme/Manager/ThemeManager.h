//
//  ThemeManager.h
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/4.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AppTheme;

@interface ThemeManager : NSObject

+ (AppTheme *)currentTheme;

@end
