//
//  PhotoBrowserHelper.h
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/1.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoBrowserHelper : NSObject

/**
 浏览一组图片
 
 @param photoSource 图片数据源
 @param viewController 所在的view controller
 @param index 起始页索引值
 */
+ (void)showWithPhotoSource:(NSArray *)photoSource
         fromViewController:(UIViewController *)viewController
              fromPageIndex:(NSInteger)index;

@end
