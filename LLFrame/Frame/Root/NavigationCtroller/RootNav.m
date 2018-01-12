//
//  RootNav.m
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/30.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#import "RootNav.h"

@interface RootNav ()

@end

@implementation RootNav

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
