//
//  MainTabBarController.m
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/30.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#import "MainTabBarController.h"

#import "RootNav.h"
#import "BestPageVC.h"
#import "FreshPageVC.h"
#import "PostVC.h"
#import "InterestVC.h"
#import "MeVC.h"

#import "AppTheme.h"

#import <SMPageControl/SMPageControl.h>
#import <EAIntroView/EAIntroView.h>

@interface MainTabBarController () <EAIntroDelegate>

@end

@implementation MainTabBarController

+ (instancetype)mainTabBarController
{
    static MainTabBarController *_mainTabBarController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSArray *viewControllers = [self setupViewControllers];
        NSArray *atts = [self setupAttributes];
        
        _mainTabBarController = [[MainTabBarController alloc] initWithViewControllers:viewControllers tabBarItemsAttributes:atts];
        
        [self customizeTabBarAppearance:_mainTabBarController];
    });
    return _mainTabBarController;
}

+ (BOOL)havePlusButton
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupGuides];
}

#pragma mark -
+ (NSArray *)setupViewControllers
{
    BestPageVC *bestPageVC = [BestPageVC new];
    RootNav *bestNav = [[RootNav alloc] initWithRootViewController:bestPageVC];
    
    FreshPageVC *freshPageVC = [FreshPageVC new];
    RootNav *freshNav = [[RootNav alloc] initWithRootViewController:freshPageVC];
    
    InterestVC *interestVC = [InterestVC new];
    RootNav *interestNav = [[RootNav alloc] initWithRootViewController:interestVC];
    
    MeVC *meVC = [MeVC new];
    RootNav *meNav = [[RootNav alloc] initWithRootViewController:meVC];
    
    return @[bestNav,freshNav,interestNav,meNav];
}

+ (NSArray *)setupAttributes
{
    NSDictionary *first = @{
                            CYLTabBarItemTitle : @"百思",
                            CYLTabBarItemImage : @"home_normal",
                            CYLTabBarItemSelectedImage : @"home_highlight",
                            };
    
    NSDictionary *second = @{
                             CYLTabBarItemTitle : @"第二个",
                             CYLTabBarItemImage : @"mycity_normal",
                             CYLTabBarItemSelectedImage : @"mycity_highlight",
                             };
    
    NSDictionary *third = @{
                            CYLTabBarItemTitle : @"第三个",
                            CYLTabBarItemImage : @"message_normal",
                            CYLTabBarItemSelectedImage : @"message_highlight",
                            };
    
    NSDictionary *fourth = @{
                             CYLTabBarItemTitle : @"我",
                             CYLTabBarItemImage : @"account_normal",
                             CYLTabBarItemSelectedImage : @"account_highlight"
                             };
    
    return @[first,second,third,fourth];
}

/**
 *  更多TabBar自定义设置
 */
+ (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController
{
    // 自定义 TabBar 高度
    tabBarController.tabBarHeight = kTabBarHeight;
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor flatGrayColor];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = kTheme.themeColor;
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

#pragma mark -
- (void)setupGuides
{
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"But every once in a while you find someone who's iridescent, and when you do, nothing will ever compare";
    page1.desc = @"有一天你会遇到一个彩虹般绚丽的人，从此以后，其他人就不过是匆匆浮云";
    page1.bgImage = [UIImage imageNamed:@"bg1"];
    page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title1"]];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"The higher I got, the more amazed I was by the view";
    page2.desc = @"我爬得越高，眼前的风景便愈发迷人";
    page2.bgImage = [UIImage imageNamed:@"bg2"];
    page2.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title2"]];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"Sometimes a little discomfort in the beginning can save a whole lot of pain down the road";
    page3.desc = @"有时起初的隐忍可以避免一路的疼痛";
    page3.bgImage = [UIImage imageNamed:@"bg3"];
    page3.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title3"]];
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.title = @"Fuck the world if you are rich, otherwise fuck yourself";
    page4.desc = @"达则兼济天下，穷则独善其身";
    page4.bgImage = [UIImage imageNamed:@"bg4"];
    page4.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title4"]];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3,page4]];
    intro.skipButtonAlignment = EAViewAlignmentCenter;
    intro.skipButtonY = 80.f;
    intro.pageControlY = 42.f;
    
    [intro setDelegate:self];
    [intro showInView:self.view animateDuration:0.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
