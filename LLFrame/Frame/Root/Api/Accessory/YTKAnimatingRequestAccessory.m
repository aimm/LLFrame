//
//  YTKAnimatingRequestAccessory.m
//  Ape_uni
//
//  Created by Chenyu Lan on 10/30/14.
//  Copyright (c) 2014 Fenbi. All rights reserved.
//

#import "YTKAnimatingRequestAccessory.h"
#import "LLAcvitityIndicator.h"

@implementation YTKAnimatingRequestAccessory

- (id)initWithAnimatingView:(UIView *)animatingView
              animatingText:(NSString *)animatingText
{
    self = [super init];
    if (self)
    {
        _animatingView = animatingView;
        _animatingText = animatingText;
    }
    return self;
}

- (id)initWithAnimatingView:(UIView *)animatingView
{
    self = [super init];
    if (self)
    {
        _animatingView = animatingView;
    }
    return self;
}

+ (id)accessoryWithAnimatingView:(UIView *)animatingView
{
    return [[self alloc] initWithAnimatingView:animatingView];
}

+ (id)accessoryWithAnimatingView:(UIView *)animatingView
                   animatingText:(NSString *)animatingText
{
    return [[self alloc] initWithAnimatingView:animatingView
                                 animatingText:animatingText];
}

- (void)requestWillStart:(id)request
{
    if (_animatingView)
    {
        [LLAcvitityIndicator show];
    }
}

- (void)requestWillStop:(id)request
{
    if (_animatingView)
    {
        [LLAcvitityIndicator dismiss];
    }
}

@end
