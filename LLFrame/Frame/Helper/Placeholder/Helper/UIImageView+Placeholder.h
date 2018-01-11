//
//  UIImageView+Placeholder.h
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/29.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Placeholder)

/**
 自动显示占位图，默认 YES
 */
@property (nonatomic,assign) BOOL automaticlyShowPlaceholderImage;

/**
 是否是头像，默认 NO
 作用：automaticlyShowPlaceholderImage 为 YES 时 显示普通占位图还是头像占位图
 */
@property (nonatomic,assign) BOOL isAvatar;

/**
 占位图，默认 nil
 */
@property (nonatomic,strong) UIImage *placeholderImage;

@end
