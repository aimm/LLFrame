//
//  BestListVC.m
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/31.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#import "BestListVC.h"

#import "BestListVideoCell.h"
#import "BestListImageCell.h"
#import "BestListTextCell.h"
#import "BestListCellModel.h"

#import "BestListApi.h"
#import "LLDataHelper.h"
#import "BestListDataEntity.h"
#import "LLEmptyHelper.h"

@interface BestListVC () <ASTableDataSource, ASTableDelegate, MJDelegate ,DataHelperDelegate ,DataHelperDataSource>

@property (nonatomic,strong) ASTableNode *tableNode;
@property (nonatomic,strong) LLDataHelper *dataHelper;
@property (nonatomic,strong) NSMutableDictionary *typeToCellClassMap;

@end

@implementation BestListVC

- (instancetype)init
{
    _tableNode = [[ASTableNode alloc] initWithStyle:1];
    
    self = [super initWithNode:_tableNode];
    
    if (self)
    {
        _tableNode.delegate = self;
        _tableNode.dataSource = self;
        _tableNode.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableNode.contentInset = UIEdgeInsetsMake(0, 0, kTabBarHeight, 0);
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableNode.view.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableNode.view showMJHeader:YES showMJFooter:YES mjDelegate:self];
    
    LLEmptyHelper *emptyHelper = [LLEmptyHelper new];
    self.tableNode.view.emptyDataSetSource = emptyHelper;
    
    [self.dataHelper loadData];
}

#pragma mark - Data helper

- (RootApi *)apiForDataHelper:(LLDataHelper *)helper
{
    NSInteger page = helper.currentPage + 1;
    BestListApi *api = [[BestListApi alloc] initWithType:self.type currentPage:page];
    return api;
}

- (void)loadDataSucceed:(LLDataHelper *)helper
{
    [self.tableNode reloadData];
    
    if (helper.hasNoMoreData)
    {
        [self.tableNode.view endRefreshingWithNoMoreData];
    }
    else
    {
        [self.tableNode.view endRefreshing];
    }
}

- (void)loadDataFailed:(LLDataHelper *)helper
{
    [self.tableNode.view endRefreshing];
    [self.tableNode reloadData];
}

- (void)dataHelper:(LLDataHelper *)helper requestError:(YTKBaseRequest *)request
{
    [self.tableNode.view endRefreshing];
    [self.tableNode reloadData];
}

#pragma mark - MJDelegate

- (void)mjheaderWantOriginalData:(UIScrollView *)scrollView
{
    [self.dataHelper reloadData];
}

- (void)mjfooterWantMoreData:(UIScrollView *)scrollView
{
    [self.dataHelper loadMoreData];
}

#pragma mark - ASTableNode

- (ASCellNode *)tableNode:(ASTableNode *)tableNode nodeForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BestListCellModel *cellModel = self.dataHelper.totalPageModels[indexPath.section];
    Class cellClass = self.typeToCellClassMap[@(cellModel.type)];
    BestListTextCell *cell = [[cellClass alloc] initWithModel:cellModel];
    return cell;
}

- (NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode
{
    return self.dataHelper.totalPageModels.count;
}

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 9.9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

#pragma mark - Lazy

- (LLDataHelper *)dataHelper
{
    if (!_dataHelper)
    {
        BestListDataEntity *entity = [BestListDataEntity new];
        _dataHelper = [[LLDataHelper alloc] initWithDataEntity:entity];
        _dataHelper.delegate = self;
        _dataHelper.dataSource = self;
    }
    return _dataHelper;
}

- (NSMutableDictionary *)typeToCellClassMap
{
    if (!_typeToCellClassMap)
    {
        _typeToCellClassMap = [NSMutableDictionary new];
        _typeToCellClassMap[@(ListTypeVideo)] = [BestListVideoCell class];
        _typeToCellClassMap[@(ListTypeImage)] = [BestListImageCell class];
        _typeToCellClassMap[@(ListTypeText)] = [BestListTextCell class];
    }
    return _typeToCellClassMap;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
