//
//  LLPhotoGroupCell.h
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/1.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import "RootCVC.h"

@class LLPhoto;
@class LLPhotoGroupCell;

@protocol LLPhotoGroupCellDelegate <NSObject>

- (void)cell:(LLPhotoGroupCell *)cell deletePhoto:(LLPhoto *)photo;

@end

@interface LLPhotoGroupCell : RootCVC

/**
 imageView 和 originalImage 用于图片浏览器的传入参数
 */
@property (nonatomic,strong,readonly) UIImageView *imageView;
@property (nonatomic,strong,readonly) UIImage *originalImage;

@property (nonatomic,weak) id <LLPhotoGroupCellDelegate> delegate;
@property (nonatomic,strong) LLPhoto *photo;

@end
