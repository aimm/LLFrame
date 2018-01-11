//
//  UIImageView+Placeholder.m
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/29.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#import "UIImageView+Placeholder.h"
#import "PlaceholderImageDrawer.h"

@implementation UIImageView (Placeholder)

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.automaticlyShowPlaceholderImage &&
        self.image == nil &&
        self.width > 0 &&
        self.height > 0)
    {
        // 绘制占位图
        UIImage *image = [PlaceholderImageDrawer placeholderImageWithSize:self.frame.size
                                                                 isAvatar:self.isAvatar];
        
        // 设置占位图
        [self setImage:image];
        
        // 关联属性
        [self setPlaceholderImage:image];
    }
}

#pragma mark - 关联自动显示占位图属性
- (void)setAutomaticlyShowPlaceholderImage:(BOOL)automaticlyShowPlaceholderImage
{
    SEL key = @selector(automaticlyShowPlaceholderImage);
    objc_setAssociatedObject(self, key, @(automaticlyShowPlaceholderImage), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)automaticlyShowPlaceholderImage
{
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    if (number) return number.boolValue;
    self.automaticlyShowPlaceholderImage = YES;
    return YES;
}

#pragma mark - 关联是否是头像属性
- (void)setIsAvatar:(BOOL)isAvatar
{
    SEL key = @selector(isAvatar);
    objc_setAssociatedObject(self, key, @(isAvatar), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isAvatar
{
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    if (number) return number.boolValue;
    self.isAvatar = NO;
    return NO;
}

#pragma mark - 关联占位图属性
- (void)setPlaceholderImage:(UIImage *)placeholderImage
{
    SEL key = @selector(placeholderImage);
    objc_setAssociatedObject(self, key, placeholderImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImage *)placeholderImage
{
    UIImage *image = objc_getAssociatedObject(self, _cmd);
    if (image)
    {
        return image;
    }
    else
    {
        if (self.automaticlyShowPlaceholderImage &&
            self.width > 0 &&
            self.height > 0)
        {
            // 绘制占位图
            UIImage *image = [PlaceholderImageDrawer placeholderImageWithSize:self.frame.size
                                                                     isAvatar:self.isAvatar];
            
            // 关联属性
            [self setPlaceholderImage:image];
            
            return image;
        }
    }
    self.placeholderImage = nil;
    return nil;
}

@end
