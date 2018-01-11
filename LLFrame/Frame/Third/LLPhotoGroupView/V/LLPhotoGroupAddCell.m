//
//  LLPhotoGroupAddCell.m
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/1.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import "LLPhotoGroupAddCell.h"

@implementation LLPhotoGroupAddCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.automaticlyShowPlaceholderImage = NO;
        imageView.image = [UIImage imageNamed:@"upload"];
        [self.contentView addSubview:imageView];
    }
    return self;
}

@end
