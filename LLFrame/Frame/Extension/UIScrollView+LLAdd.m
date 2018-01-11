//
//  UIScrollView+LLAdd.m
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/29.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#import "UIScrollView+LLAdd.h"
#import <MJRefresh/MJRefresh.h>

@implementation UIScrollView (LLAdd)

- (void)showMJHeader:(BOOL)showMJHeader
        showMJFooter:(BOOL)showMJFooter
          mjDelegate:(id <MJDelegate>)mjDelegate
{
    if (!mjDelegate) return;
    
    self.mj_header = showMJHeader == YES ? [self getCustomMJHeader:mjDelegate] : nil;
    self.mj_footer = showMJFooter == YES ? [self getCustomMJFooter:mjDelegate] : nil;
}

- (MJRefreshHeader *)getCustomMJHeader:(id <MJDelegate>)mjDelegate
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:mjDelegate refreshingAction:@selector(mjheaderWantOriginalData:)];
    
    return header;
}

- (MJRefreshFooter *)getCustomMJFooter:(id <MJDelegate>)mjDelegate
{
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:mjDelegate refreshingAction:@selector(mjfooterWantMoreData:)];
    
    return footer;
}

- (void)endRefreshing
{
    if (self.mj_header)
    {
        [self.mj_header endRefreshing];
    }
    if (self.mj_footer)
    {
        [self.mj_footer endRefreshing];
    }
}

- (void)endRefreshingWithNoMoreData
{
    if (self.mj_header)
    {
        [self.mj_header endRefreshing];
    }
    if (self.mj_footer)
    {
        [self.mj_footer endRefreshingWithNoMoreData];
    }
}

#pragma mark - 全屏侧滑手势在scrollview左边界的兼容
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (self.contentOffset.x <= 0)
    {
        if ([otherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"_FDFullscreenPopGestureRecognizerDelegate")])
        {
            return YES;
        }
    }
    return NO;
}

@end
