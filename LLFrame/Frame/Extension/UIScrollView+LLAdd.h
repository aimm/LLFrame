//
//  UIScrollView+LLAdd.h
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/29.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MJDelegate;

@interface UIScrollView (LLAdd)

/**
 设置上下拉刷新

 @param showMJHeader 是否显示下拉刷新
 @param showMJFooter 是否显示上拉加载更多
 @param mjDelegate 上下拉代理
 */
- (void)showMJHeader:(BOOL)showMJHeader
        showMJFooter:(BOOL)showMJFooter
          mjDelegate:(id <MJDelegate>)mjDelegate;

/**
 结束上下拉刷新
 */
- (void)endRefreshing;

/**
 结束上下拉刷新并告知没有更多数据了
 */
- (void)endRefreshingWithNoMoreData;

@end

#pragma mark - MJDelegate
@protocol MJDelegate <NSObject>

/**
 获取初始数据
 */
- (void)mjheaderWantOriginalData:(UIScrollView *)scrollView;

@optional

/**
 获取更多数据
 */
- (void)mjfooterWantMoreData:(UIScrollView *)scrollView;

@end
