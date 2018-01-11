//
//  LLPhoto.h
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/1.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLPhoto : NSObject

/**
 网络图片URL
 */
@property (nonatomic,strong) NSURL *imageURL;

/**
 本地图片文件
 */
@property (nonatomic,strong) UIImage *image;


+ (instancetype)photoWithImage:(UIImage *)image;
+ (instancetype)photoWithURL:(NSURL *)url;
+ (instancetype)photoWithURLString:(NSString *)string;

@end
