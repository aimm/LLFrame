//
//  LLPhoto.m
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/1.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import "LLPhoto.h"

@implementation LLPhoto

+ (instancetype)photoWithImage:(UIImage *)image
{
    LLPhoto *photo = [LLPhoto new];
    photo.image = image;
    return photo;
}

+ (instancetype)photoWithURL:(NSURL *)url
{
    LLPhoto *photo = [LLPhoto new];
    photo.imageURL = url;
    return photo;
}

+ (instancetype)photoWithURLString:(NSString *)string
{
    LLPhoto *photo = [LLPhoto new];
    photo.imageURL = [NSURL URLWithString:string];
    return photo;
}

@end
