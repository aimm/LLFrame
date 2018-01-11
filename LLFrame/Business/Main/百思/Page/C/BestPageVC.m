//
//  BestPageVC.m
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/30.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#import "BestPageVC.h"
#import "BestListVC.h"
#import "ShareHelper.h"
#import "AppTheme.h"

@interface BestPageVC ()

@property (nonatomic,strong) NSArray *pages;

@end

@implementation BestPageVC

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.titleSizeNormal = AdaptedWidth(13.5);
        self.titleSizeSelected = AdaptedWidth(15);
        
        self.titleColorSelected = kTheme.themeColor;
        self.titleColorNormal = [UIColor flatBlackColorDark];
        
        self.menuViewStyle = WMMenuViewStyleLine;
        self.automaticallyCalculatesItemWidths = YES;
        
        self.values = [NSMutableArray new];
        self.keys = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kNavBarHeight, 0, KScreenWidth - 2 * kNavBarHeight, kNavBarHeight)];
    titleLabel.textAlignment = 1;
    titleLabel.textColor = kTheme.themeColor;
    titleLabel.font = BoldSystemFont(17);
    titleLabel.text = @"百思不得姐";
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:4 target:self action:@selector(share)];
    self.navigationItem.rightBarButtonItem = shareItem;
}

- (void)share
{
    UIImage *image = [UIImage imageNamed:@"budejie"];
    NSString *text = @"百思不得姐";
    NSURL *url = [NSURL URLWithString:@"http://www.budejie.com"];
    [ShareHelper systemShareWithImage:image Text:text url:url vc:self];
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView
{
    return CGRectMake(0, kTopHeight, kScreenWidth, AdaptedHeight(44));
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView
{
    return CGRectMake(0, kTopHeight + AdaptedHeight(44), KScreenWidth, kScreenHeight - kTopHeight - AdaptedHeight(44));
}
#pragma mark - Datasource & Delegate
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController
{
    return self.pages.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index
{
    BestListVC *vc = [BestListVC new];
    if (index == 0)
    {
        vc.type = ListTypeAll;
    }
    else if (index == 1)
    {
        vc.type = ListTypeVideo;
    }
    else if (index == 2)
    {
        vc.type = ListTypeImage;
    }
    else
    {
        vc.type = ListTypeText;
    }
    
    return vc;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index
{
    return self.pages[index];
}

- (NSArray *)pages
{
    if (!_pages)
    {
        _pages = @[@"推荐",@"视频",@"图片",@"段子"];
    }
    return _pages;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
