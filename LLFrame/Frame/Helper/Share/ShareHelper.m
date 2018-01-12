//
//  ShareHelper.m
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/1.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import "ShareHelper.h"

#import <Social/Social.h>

//// 分享
//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKConnector/ShareSDKConnector.h>
//
//// 腾讯开放平台（对应QQ和QQ空间）SDK头文件
//#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/QQApiInterface.h>
//
//// 新浪微博SDK头文件
//#import "WeiboSDK.h"
//
//// 微信SDK头文件
//#import "WXApi.h"
//
//// 微信
//#define WXAppId             @""
//#define WXAppSecret         @""
//
//// QQ
//#define QQAppId             @""
//#define QQAppKey            @""
//
//// 新浪微博
//#define WBAppKey            @""
//#define WBAppSecret         @""
//#define WBRedirectUri       @"http://www.sharesdk.cn"

@implementation ShareHelper

//+ (void)config
//{
//    [ShareSDK registerActivePlatforms:@[@(SSDKPlatformTypeSinaWeibo),@(SSDKPlatformSubTypeWechatSession), @(SSDKPlatformSubTypeWechatTimeline), @(SSDKPlatformTypeQQ) ,@(SSDKPlatformTypeCopy)] onImport:^(SSDKPlatformType platformType) {
//
//        switch (platformType)
//        {
//            case SSDKPlatformTypeWechat:
//                [ShareSDKConnector connectWeChat:[WXApi class]];
//                break;
//
//            case SSDKPlatformTypeQQ:
//                [ShareSDKConnector connectQQ:[QQApiInterface class]
//                           tencentOAuthClass:[TencentOAuth class]];
//                break;
//
//            case SSDKPlatformTypeSinaWeibo:
//                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
//                break;
//
//            default:
//                break;
//        }
//
//    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
//
//        switch (platformType)
//        {
//            case SSDKPlatformTypeSinaWeibo:
//                //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
//                [appInfo SSDKSetupSinaWeiboByAppKey:WBAppKey
//                                          appSecret:WBAppSecret
//                                        redirectUri:WBRedirectUri
//                                           authType:SSDKAuthTypeBoth];
//                break;
//
//
//            case SSDKPlatformTypeWechat:
//                [appInfo SSDKSetupWeChatByAppId:WXAppId
//                                      appSecret:WXAppSecret];
//                break;
//
//
//            case SSDKPlatformTypeQQ:
//                [appInfo SSDKSetupQQByAppId:QQAppId
//                                     appKey:QQAppKey
//                                   authType:SSDKAuthTypeBoth];
//                break;
//
//            default:
//                break;
//        }
//
//    }];
//}

+ (void)systemShareWithImage:(UIImage *)image Text:(NSString *)text url:(NSURL *)url vc:(UIViewController *)vc;
{
    // 1.数据
    NSMutableArray *activityItems = [NSMutableArray new];
    if (image) [activityItems addObject:image];
    if (text.length > 0) [activityItems addObject:text];
    if (url) [activityItems addObject:url];
    
    // 2.分享
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    [vc presentViewController:activityVC animated:YES completion:nil];

    // 3.分享回调
    [activityVC setCompletionWithItemsHandler:^(NSString * __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
        
        if (completed)
        {
            NSString *status = @"分享成功!";
            if ([activityType isEqualToString:UIActivityTypeCopyToPasteboard])
            {
                status = @"已复制!";
            }
            
            [SVProgressHUD showSuccessWithStatus:status];
        }
        else
        {
            NSString *status = @"分享失败!";
            if ([activityType isEqualToString:UIActivityTypeCopyToPasteboard])
            {
                status = @"复制失败!";
            }
            
            [SVProgressHUD showErrorWithStatus:status];
        }

    }];
}

@end
