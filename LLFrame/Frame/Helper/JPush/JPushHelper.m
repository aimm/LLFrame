//
//  JPushHelper.m
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/5.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import "JPushHelper.h"

#ifdef DEBUG

#define JPushAppKey           @""
#define JPushChannel          @"AppStore"//应用程序包的下载渠道
#define JPushApsForProduction FALSE//表示采用的是开发证书

#else

#define JPushAppKey           @""
#define JPushChannel          @"AppStore"//应用程序包的下载渠道
#define JPushApsForProduction TRUE//表示采用生产证书

#endif

@implementation JPushHelper

+ (void)config:(NSDictionary *)launchOptions
{
    
}

@end
