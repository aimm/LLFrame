//
//  PlaceholderImageDrawer.h
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/29.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 占位图专用图片绘制器
 */
@interface PlaceholderImageDrawer : NSObject

/**
 绘制普通占位图

 @param size 占位图大小
 @return 指定大小的占位图
 */
+ (UIImage *)placeholderImageWithSize:(CGSize)size;

/**
 绘制占位图

 @param size 占位图大小
 @param isAvatar 是否是头像，是：绘制头像占位图，否：绘制普通占位图
 @return 指定大小的占位图
 */
+ (UIImage *)placeholderImageWithSize:(CGSize)size isAvatar:(BOOL)isAvatar;

@end
