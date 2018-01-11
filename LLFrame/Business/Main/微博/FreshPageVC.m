//
//  FreshPageVC.m
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/30.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#import "FreshPageVC.h"
#import "LLEmptyHelper.h"

@interface FreshPageVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation FreshPageVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    LLEmptyHelper *emptyHelper = [LLEmptyHelper new];
    [emptyHelper setDescription:@"敬请期待" forStatus:ResponseStatusDefault];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopHeight, KScreenWidth, KScreenHeight - kTopHeight - kTabBarHeight) style:0];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.emptyDataSetSource = emptyHelper;
    tableView.tableFooterView = [UIView new];
    [self.view addSubview:tableView];
    
    [tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:3 reuseIdentifier:@"cell"];
        cell.textLabel.text = @"1";
    }
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
