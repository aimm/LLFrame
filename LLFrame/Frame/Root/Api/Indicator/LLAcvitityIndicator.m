//
//  LLAcvitityIndicator.m
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/30.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#import "LLAcvitityIndicator.h"

@implementation LLAcvitityIndicator

+ (instancetype)sharedIndicator
{
    static LLAcvitityIndicator *_sharedIndicator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        CGFloat rect = AdaptedWidth(34);
        CGFloat x = (KScreenWidth - rect) * 0.5;
        CGFloat y = (KScreenHeight - rect) * 0.5;
        _sharedIndicator = [[self alloc] initWithFrame:CGRectMake(x, y, rect, rect)];
    });
    return _sharedIndicator;
}

+ (void)show
{
    UIActivityIndicatorView *indicator = [self sharedIndicator];
    if (indicator.superview == nil)
    {
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        [window addSubview:indicator];
    }
    [indicator.superview bringSubviewToFront:indicator];
    [indicator startAnimating];
    indicator.hidden = NO;
}

+ (void)dismiss
{
    UIActivityIndicatorView *indicator = [self sharedIndicator];
    [indicator stopAnimating];
    indicator.hidden = YES;
}

@end
