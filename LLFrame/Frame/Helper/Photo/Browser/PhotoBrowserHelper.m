//
//  PhotoBrowserHelper.m
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/1.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import "PhotoBrowserHelper.h"
#import <IDMPhotoBrowser/IDMPhotoBrowser.h>
#import "LLPhoto.h"

@implementation PhotoBrowserHelper

+ (void)showWithPhotoSource:(NSArray *)photoSource
         fromViewController:(UIViewController *)viewController
              fromPageIndex:(NSInteger)index
{
    NSArray *IDMPhotosArray = [self convertPhotoSource:photoSource];
    
    IDMPhotoBrowser *browser = [[IDMPhotoBrowser alloc] initWithPhotos:IDMPhotosArray];
    
    browser.displayActionButton = NO;
    browser.displayArrowButton = NO;
    browser.displayCounterLabel = YES;
    browser.displayDoneButton = NO;
    browser.dismissOnTouch = YES;
    browser.autoHideInterface = NO;
    [browser setInitialPageIndex:index];
    
    [viewController presentViewController:browser animated:YES completion:nil];
}

#pragma mark - 转换
+ (NSArray *)convertPhotoSource:(NSArray *)photoSource
{
    NSMutableArray *temp = [NSMutableArray new];
    
    [photoSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        IDMPhoto *IDMPhotoObjc = [self convertToIDMPhoto:obj];
        if (IDMPhotoObjc)
        {
            [temp addObject:IDMPhotoObjc];
        }
    }];
    
    return temp.copy;
}

+ (IDMPhoto *)convertToIDMPhoto:(id)obj
{
    IDMPhoto *IDMPhotoObj = nil;
    
    // 兼容 网络 图片
    if ([obj isKindOfClass:[NSString class]])
    {
        NSURL *url = [NSURL URLWithString:obj];
        IDMPhotoObj = [IDMPhoto photoWithURL:url];
    }
    else if ([obj isKindOfClass:[NSURL class]])
    {
        IDMPhotoObj = [IDMPhoto photoWithURL:obj];
    }
    // 兼容 UIimage 图片
    else if ([obj isKindOfClass:[UIImage class]])
    {
        IDMPhotoObj = [IDMPhoto photoWithImage:obj];
    }
    // 兼容LLPhoto
    else if ([obj isKindOfClass:[LLPhoto class]])
    {
        LLPhoto *photo = (LLPhoto *)obj;
        if (photo.image)
        {
            IDMPhotoObj = [IDMPhoto photoWithImage:photo.image];
        }
        else if (photo.imageURL)
        {
            IDMPhotoObj = [IDMPhoto photoWithURL:photo.imageURL];
        }
    }
    
    return IDMPhotoObj;
}

@end
