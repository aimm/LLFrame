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
        _mainTabBarController = [MainTabBarController new];
    });
    return _mainTabBarController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupViewControllers];
    
    [self setupGuides];
}

#pragma mark -
- (void)setupViewControllers
{
    BestPageVC *bestPageVC = [BestPageVC new];
    RootNav *bestNav = [self setupNavWithViewController:bestPageVC
                                                  title:@"不得姐"
                                        normalImageName:@""
                                      selectedImageName:@""];
    
    FreshPageVC *freshPageVC = [FreshPageVC new];
    RootNav *freshNav = [self setupNavWithViewController:freshPageVC
                                                   title:@"微博"
                                         normalImageName:@""
                                       selectedImageName:@""];
    
    PostVC *postVC = [PostVC new];
    RootNav *postNav = [self setupNavWithViewController:postVC
                                                  title:@"没想好"
                                        normalImageName:@""
                                      selectedImageName:@""];
    
    InterestVC *interestVC = [InterestVC new];
    RootNav *interestNav = [self setupNavWithViewController:interestVC
                                                      title:@"没想好"
                                            normalImageName:@""
                                          selectedImageName:@""];
    
    MeVC *meVC = [MeVC new];
    RootNav *meNav = [self setupNavWithViewController:meVC
                                                title:@"我"
                                      normalImageName:@""
                                    selectedImageName:@""];
    
    self.viewControllers = @[bestNav,freshNav,postNav,interestNav,meNav];
}

- (RootNav *)setupNavWithViewController:(UIViewController *)vc
                                  title:(NSString *)title
                        normalImageName:(NSString *)normalImageName
                      selectedImageName:(NSString *)selectedImageName
{
    RootNav *nav = [[RootNav alloc] initWithRootViewController:vc];
    vc.navigationItem.title = title;
    nav.hidesNavigationBarHairline = YES;
    
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:normalImage selectedImage:selectedImage];
    
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}
                        forState:UIControlStateNormal];
    
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:kTheme.themeColor}
                        forState:UIControlStateSelected];
    
    [nav setTabBarItem:item];
    
    return nav;
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
