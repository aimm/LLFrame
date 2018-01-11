//
//  LLPhotoGroupCell.m
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/1.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import "LLPhotoGroupCell.h"
#import "LLPhoto.h"

@interface LLPhotoGroupCell ()

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) NSURL *imageURL;
@property (nonatomic,strong) UIImage *originalImage;

@end

@implementation LLPhotoGroupCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_imageView];
        
        //
        CGFloat rect = AdaptedWidth(20);
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.frame = CGRectMake(self.width - rect, 0, rect, rect);
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"delete_red"] forState:0];
        [deleteBtn addTarget:self action:@selector(deleteBtnCliced) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:deleteBtn];
    }
    return self;
}

- (void)setPhoto:(LLPhoto *)photo
{
    _photo = photo;
    
    // 优先设置本地图片
    if (_photo.image)
    {
        // 取消上个网络图片
        [self setImageURL:nil];
        // 设置原图
        [self setOriginalImage:_photo.image];
    }
    
    // 其次设置网络图片
    else if (_photo.imageURL)
    {
        // 取消当前图片
        [self setOriginalImage:nil];
        // 设置网络图片
        [self setImageURL:_photo.imageURL];
    }
    
    // 都没有的情况下清空，目前应该走不到这里
    else
    {
        [self clearImage];
    }
}

#pragma mark - 设置原图
- (void)setOriginalImage:(UIImage *)originalImage
{
    _originalImage = originalImage;
    
    // 如果是网络图片下载完成
    if (self.photo.image != _originalImage)
    {
        self.photo.image = _originalImage;
    }
    
    UIImage *displayImage = _originalImage;
    
    // 原图存在的情况下，切出一个合适大小的展示图，否则不显示图
    if (_originalImage)
    {
        CGFloat imageWidth = _originalImage.size.width;
        CGFloat imageHeight = _originalImage.size.height;
        
        // 超长图
        if (imageHeight > 2 * imageWidth)
        {
            _imageView.contentMode = UIViewContentModeTop;
        }
        
        // 超宽图
        else if (imageWidth > 2 * imageHeight)
        {
            _imageView.contentMode = UIViewContentModeLeft;
        }
        
        // 中长/中宽图
        else
        {
            CGFloat rect = MIN(imageWidth, imageHeight);
            displayImage =  [_originalImage imageByResizeToSize:CGSizeMake(rect, rect) contentMode:UIViewContentModeCenter];
            _imageView.contentMode = UIViewContentModeScaleToFill;
        }
    }
    
    _imageView.image = displayImage;
}

#pragma mark - 设置网络图片
- (void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    
    if (_imageURL)
    {
        __weak LLPhotoGroupCell *weakSelf = self;
        
        [_imageView setImageWithURL:_imageURL placeholder:_imageView.placeholderImage options:YYWebImageOptionProgressive completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
            
            if (image)
            {
                [weakSelf setOriginalImage:image];
            }
        }];
    }
    else
    {
        [_imageView setImageURL:nil];
    }
}

#pragma mark - 清空
- (void)clearImage
{
    _imageView.image = _imageView.placeholderImage;
}

#pragma mark - 点击删除
- (void)deleteBtnCliced
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cell:deletePhoto:)])
    {
        [self.delegate cell:self deletePhoto:self.photo];
    }
}

@end
