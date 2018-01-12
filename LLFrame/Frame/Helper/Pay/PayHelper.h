//
//  PayHelper.h
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/1.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

//@class PayHelper;
//
//@protocol PayHelperDelegate <NSObject>
//
///**
// 通知代理进行支付成功的处理
//
// @param helper 助手对象
// */
//- (void)handlePaySucceed:(PayHelper *)helper;
//
//@end

/**
 支付助手，方便统一管理支付
 */
@interface PayHelper : NSObject

//@property (nonatomic,weak) id <PayHelperDelegate> delegate;
//@property (nonatomic,weak) UIViewController *viewControllerForHUD;
//
///**
// 支付宝支付
//
// @param orderString 订单字符串
// */
//- (void)aliPayWithOrderString:(NSString *)orderString;
//
//
///**
// 微信支付
//
// @param dic 订单信息字典
// */
//- (void)wxPayWithOrderInfoDic:(NSDictionary *)dic;

@end
