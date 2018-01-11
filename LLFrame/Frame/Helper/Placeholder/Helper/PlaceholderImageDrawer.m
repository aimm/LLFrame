//
//  PlaceholderImageDrawer.m
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/29.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#import "PlaceholderImageDrawer.h"
#import "AppTheme.h"

static NSString * AvatarPlaceholderImageName = @"";
static NSString * NormalPlaceholderImageName = @"";

@implementation PlaceholderImageDrawer

+ (UIImage *)placeholderImageWithSize:(CGSize)size
{
    return [self placeholderImageWithSize:size isAvatar:NO];
}

+ (UIImage *)placeholderImageWithSize:(CGSize)size isAvatar:(BOOL)isAvatar
{
    UIImage *image = [self placeholderImageWithSize:size
                                           isAvatar:isAvatar
                                    backgroundColor:HUI];
    return image;
}

+ (UIImage *)placeholderImageWithSize:(CGSize)size
                             isAvatar:(BOOL)isAvatar
                      backgroundColor:(UIColor *)backgroundColor

{
    UIImage *cachedImage = [self imageCachedForSize:size
                                           isAvatar:isAvatar
                                    backgroundColor:backgroundColor];
    if (!cachedImage)
    {
        // 预计高度
        CGFloat PreferHeight = isAvatar ? MIN(size.width, size.height) : MIN(size.width, size.height) * 0.5;
        
        // 画布大小
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        // 开始绘制
        UIGraphicsBeginImageContextWithOptions(size,NO,0);
        
        // 背景色
        [backgroundColor setFill];
        UIRectFill(rect);
        
        // 图标
        UIImage *avatar = [UIImage imageNamed:AvatarPlaceholderImageName];
        UIImage *normal = [[UIImage imageNamed:NormalPlaceholderImageName] imageByTintColor:kTheme.themeColor];
        UIImage *tintImage = isAvatar ? avatar : normal;
        
        // 图标宽
        CGFloat tintImageWith = PreferHeight;
        
        // 图标高
        CGFloat tintImageHeight = PreferHeight;
        
        // 图标X
        CGFloat tintImageX = (size.width - tintImageWith) * 0.5;
        
        // 图标Y
        CGFloat tintImageY = (size.height - tintImageHeight) * 0.5;
        
        // 图标frame
        CGRect tintImageRect = CGRectMake(tintImageX, tintImageY, tintImageWith, tintImageHeight);
        
        // 将图片绘制进去
        [tintImage drawInRect:tintImageRect];
        
        // 生成图片
        cachedImage = UIGraphicsGetImageFromCurrentImageContext();
        
        // 结束绘制
        UIGraphicsEndImageContext();
        
        //缓存
        [self cacheImage:cachedImage isAvatar:isAvatar backgroundColor:backgroundColor];
    }
    
    return cachedImage;
}

+ (UIImage *)imageCachedForSize:(CGSize)size
                       isAvatar:(BOOL)isAvatar
                backgroundColor:(UIColor *)backgroundColor
{
    const CGFloat *components = CGColorGetComponents(backgroundColor.CGColor);
    
    NSString *colorAsString = [NSString stringWithFormat:@"%f,%f,%f,%f", components[0], components[1], components[2], components[3]];
    
    NSString *key = [NSString stringWithFormat:@"%0.1fx%0.1f|%i|%@", size.width, size.height, isAvatar, colorAsString];
    
    UIImage *cachedImage = [[YYImageCache sharedCache] getImageForKey:key];
    
    return cachedImage;
}

+ (void)cacheImage:(UIImage *)image
          isAvatar:(BOOL)isAvatar
   backgroundColor:(UIColor *)backgroundColor
{
    const CGFloat *components = CGColorGetComponents(backgroundColor.CGColor);
    
    NSString *colorAsString = [NSString stringWithFormat:@"%f,%f,%f,%f", components[0], components[1], components[2], components[3]];
    
    NSString *key = [NSString stringWithFormat:@"%0.1fx%0.1f|%i|%@", image.size.width, image.size.height, isAvatar, colorAsString];
    
    [[YYImageCache sharedCache] setImage:image forKey:key];
}

@end
