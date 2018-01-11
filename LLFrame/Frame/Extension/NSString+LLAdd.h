//
//  NSString+LLAdd.h
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/1.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LLAdd)

/// 是否为纯数字
- (BOOL)isPureInt;

/// 是否为纯浮点型
- (BOOL)isPureFloat;

/// 是否为字母（包含大小写）
- (BOOL)isLetter;

/// 是否为汉字
- (BOOL)isChinese;

/// 含汉字的字符串长度
- (NSUInteger)chineseLength;

@end
