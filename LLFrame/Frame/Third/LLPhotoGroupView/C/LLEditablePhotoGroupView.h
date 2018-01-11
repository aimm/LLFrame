//
//  LLEditablePhotoGroupView.h
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/1.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import "RootView.h"

@class LLPhoto;

@interface LLEditablePhotoGroupView : RootView

/**
 列数 默认4列
 */
@property (nonatomic,assign) int columnCount;

/**
 最多可选择的照片数量 默认 9 张
 */
@property (nonatomic,assign) int maxCount;

/**
 已选择图片数量
 */
@property (nonatomic,assign,readonly) NSInteger selectedCount;

/**
 所在的视图控制器
 照片选择器或照相机须由viewContoller弹出
 */
@property (nonatomic,weak) UIViewController *viewController;

/**
 数据源
 */
@property (nonatomic,strong) NSMutableArray <LLPhoto *> *modelsArray;


/**
 提供便捷的方法提取数组中的图片地址或文件
 
 @return 纯图片地址数组或纯文件数组
 */
- (NSArray *)getPureImageURLsArray;
- (NSArray *)getPureImageFilesArray;

@end
