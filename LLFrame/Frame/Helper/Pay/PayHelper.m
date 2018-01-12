//
//  PayHelper.m
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/1.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import "PayHelper.h"

//#import <AlipaySDK/AlipaySDK.h>
//#import "WXApi.h"
//#import "AppDelegate.h"

@interface PayHelper ()
/**<PayDelegate>*/

@end

@implementation PayHelper

//- (instancetype)init
//{
//    self = [super init];
//    if (self)
//    {
//        // 支付代理
//        AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//        app.payDelegate = self;
//    }
//    return self;
//}
//
//#pragma mark - 支付宝支付
//- (void)aliPayWithOrderString:(NSString *)orderString
//{
//    [[AlipaySDK defaultService] payOrder:orderString fromScheme:AliPayAppScheme callback:^(NSDictionary *resultDic) {
//
//        [self aliPayCompletedWithResult:resultDic];
//    }];
//}
//
//#pragma mark - 支付宝支付结果回调
//- (void)aliPayCompletedWithResult:(NSDictionary *)result
//{
//    // 成功
//    if([result[@"resultStatus"] intValue] == 9000)
//    {
//        [self handlePaySucceed];
//    }
//
//    // 判断resultStatus 为非“9000”则代表可能支付失败
//    else if ([result[@"resultStatus"] intValue] == 8000)
//    {
//        NSString *msg = @"支付渠道原因或者系统原因还在等待支付结果确认,请耐心等候或者到未消费订单里查看";
//        [SysAlertHelper showSystemAlertInVC:self.viewControllerForHUD
//                                      title:@"提示"
//                                    message:msg
//                             cancelBtnTitle:@"确定"
//                      cancelBtnClickedBlock:nil];
//    }
//    else
//    {
//        NSString *msg = result[@"memo"];
//        if (msg.length <= 0)
//        {
//            msg = @"未知错误";
//        }
//
//        [SysAlertHelper showSystemAlertInVC:self.viewControllerForHUD
//                                      title:@"提示"
//                                    message:msg
//                             cancelBtnTitle:@"确定"
//                      cancelBtnClickedBlock:nil];
//    }
//}
//
//#pragma mark - 微信支付
//- (void)wxPayWithOrderInfoDic:(NSDictionary *)dic
//{
//    BOOL isRegisted = [WXApi registerApp:WXAppId];
//    if (isRegisted)
//    {
//        //生成支付请求
//        PayReq* req   = [[PayReq alloc] init];
//        req.partnerId = dic[@"partnerid"];
//        req.prepayId  = dic[@"prepayid"];
//        req.nonceStr  = dic[@"noncestr"];
//        req.timeStamp = [dic[@"timestamp"] intValue];
//        req.package   = dic[@"package"];
//        req.sign      = dic[@"sign"];
//
//        //发送支付请求
//        BOOL sendSucceed = [WXApi sendReq:req];
//        if (!sendSucceed)
//        {
//            [SVProgressHUD showInfoWithStatus:@"调起微信支付失败!"];
//        }
//    }
//    else
//    {
//        [SVProgressHUD showInfoWithStatus:@"微信注册失败!"];
//    }
//}
//
//#pragma mark - 微信支付结果回调
//- (void)wxPayCompletedWithResult:(BaseResp *)resp
//{
//    switch (resp.errCode)
//    {
//        case WXSuccess:
//        {
//            //支付成功
//            [self handlePaySucceed];
//        }
//            break;
//
//        case WXErrCodeCommon:
//        {
//            NSString *msg = @"未知错误!";
//            if (resp.errStr.length > 0)
//            {
//                msg = resp.errStr;
//            }
//
//            [SysAlertHelper showSystemAlertInVC:self.viewControllerForHUD
//                                          title:@"提示"
//                                        message:msg
//                                 cancelBtnTitle:@"确定"
//                          cancelBtnClickedBlock:nil];
//        }
//            break;
//
//        default:
//        {
//            [SysAlertHelper showSystemAlertInVC:self.viewControllerForHUD
//                                          title:@"提示"
//                                        message:@"用户取消支付"
//                                 cancelBtnTitle:@"确定"
//                          cancelBtnClickedBlock:nil];
//        }
//            break;
//    }
//}
//
//#pragma mark - 支付宝 或 微信 支付成功
//- (void)handlePaySucceed
//{
//    [SVProgressHUD showSuccessWithStatus:@"支付成功!"];
//
//    if (self.delegate && [self.delegate respondsToSelector:@selector(handlePaySucceed:)])
//    {
//        [self.delegate handlePaySucceed:self];
//    }
//}

@end
