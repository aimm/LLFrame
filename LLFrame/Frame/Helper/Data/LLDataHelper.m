//
//  LLDataHelper.m
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/2.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import "LLDataHelper.h"
#import "RootApi.h"
#import "AppBuilder.h"

@interface LLDataHelper () <YTKRequestDelegate>

@property (nonatomic,strong) LLDataEntity *entity;

@end

@implementation LLDataHelper

- (instancetype)init
{
    return [self initWithDataEntity:nil];
}

- (instancetype)initWithDataEntity:(LLDataEntity *)entity
{
    self = [super init];
    if (self)
    {
        self.entity = entity ?: [LLDataEntity new];
        
        // 断网重连刷新数据
        if (self.reloadDataAtNetworkReconnect)
        {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkReconnect) name:NetworkReconnectNotificationName object:nil];
        }
        
        // 登录/退出 刷新数据
        if (self.reloadDataAtLoginStatusChanged)
        {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLoginStatusChagend) name:LoginStatusChangedNotificationName object:nil];
        }
    }
    return self;
}

#pragma mark - 断网重连后 是否刷新数据
- (BOOL)reloadDataAtNetworkReconnect
{
    return YES;
}
- (void)handleNetworkReconnect
{
    if (self.reloadDataAtNetworkReconnect)
    {
        [self reloadData];
    }
}

#pragma mark - 登录状态改变后 是否刷新数据
- (BOOL)reloadDataAtLoginStatusChanged
{
    return NO;
}
- (void)handleLoginStatusChagend
{
    if (self.reloadDataAtLoginStatusChanged)
    {
        [self reloadData];
    }
}

#pragma mark -
- (void)loadData
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(apiForDataHelper:)])
    {
        RootApi *api = [self.dataSource apiForDataHelper:self];
        api.delegate = self;
        [api start];
    }
    else
    {
        NSLog(@"Lack of api to load data!");
    }
}

- (void)loadMoreData
{
    if (self.hasNoMoreData == NO)
    {
        [self loadData];
    }
}

- (void)reloadData
{
    self.entity.currentPage = 0;
    [self.totalPageModels removeAllObjects];
    [self loadData];
}

#pragma mark - YTK delegate
- (void)requestFinished:(__kindof YTKBaseRequest *)request
{
    [self.entity modelSetWithJSON:request.responseString];
    [self.entity handleData];
    
    if (self.status == ResponseStatusSuccess)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataSucceed:)])
        {
            [self.delegate loadDataSucceed:self];
        }
    }
    else if (self.status == ResponseStatusFail)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataFailed:)])
        {
            [self.delegate loadDataFailed:self];
        }
    }
}

- (void)requestFailed:(__kindof YTKBaseRequest *)request
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dataHelper:requestError:)])
    {
        [self.delegate dataHelper:self requestError:request];
    }
}

#pragma mark - Shorcuts
- (ResponseStatus)status
{
    return self.entity.status;
}
- (NSString *)message
{
    return self.entity.message;
}
- (NSInteger)currentPage
{
    return self.entity.currentPage;
}
- (BOOL)hasNoMoreData
{
    return self.entity.hasNoMoreData;
}
- (NSMutableArray *)totalPageModels
{
    return self.entity.totalPageModels;
}

#pragma mark -
- (void)dealloc
{
    // 移除 断网重连刷新数据 观察者
    if (self.reloadDataAtNetworkReconnect)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:NetworkReconnectNotificationName object:nil];
    }
    
    // 移除 登录/退出 刷新数据 观察者
    if (self.reloadDataAtLoginStatusChanged)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:LoginStatusChangedNotificationName object:nil];
    }
}

@end
