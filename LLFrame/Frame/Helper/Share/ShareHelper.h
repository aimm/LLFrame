//
//  ShareHelper.h
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/1.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ShareInfo;

@interface ShareHelper : NSObject

+ (void)config;

+ (void)systemShareWithImage:(UIImage *)image
                        Text:(NSString *)text
                         url:(NSURL *)url
                          vc:(UIViewController *)vc;

@end
