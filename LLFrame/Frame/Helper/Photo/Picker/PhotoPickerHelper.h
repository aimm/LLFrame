//
//  PhotoPickerHelper.h
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/1.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLPhoto.h"

@class PhotoPickerHelper;

@protocol LLPhotoPickerDelegate <NSObject>

@required

- (void)photoPickerHelper:(PhotoPickerHelper *)helper
       takePhotoCompleted:(LLPhoto *)photo;

- (void)photoPickerHelper:(PhotoPickerHelper *)helper
     selectPhotoCompleted:(NSArray <LLPhoto *> *)selectedPhotos;

@end

@interface PhotoPickerHelper : NSObject

/**
 最大可选择照片数量
 */
@property (nonatomic,assign) int maxCount;

/**
 照片页面瀑布流列数
 */
@property (nonatomic,assign) int columnCount;

/**
 允许裁剪，单选才有效
 */
@property (nonatomic, assign) BOOL allowCrop;

/**
 裁剪框的frame
 NOTE:宽度必须为屏幕宽，如果不是则自动缩放
 */
@property (nonatomic, assign) CGRect cropFrame;

/**
 照片页面必须显示在一个viewController里
 */
@property (nonatomic,weak) UIViewController *viewController;

/**
 代理
 */
@property (nonatomic,weak) id <LLPhotoPickerDelegate> delegate;

/**
 显示照片选择器
 */
- (void)showImagePicker;

/**
 拍照
 */
- (void)takePhoto;

@end
