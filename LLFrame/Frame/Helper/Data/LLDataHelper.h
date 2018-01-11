//
//  LLDataHelper.h
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/2.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import "RootModel.h"
#import "LLDataEntity.h"

@class YTKBaseRequest;
@class RootApi;
@protocol DataHelperDelegate;
@protocol DataHelperDataSource;

#pragma mark -
@interface LLDataHelper : RootModel

/**
 Use only this methord to create a data helper

 @param entity If nil ,will create a LLDataEntity to instead
 */
- (instancetype)initWithDataEntity:(LLDataEntity *)entity;

@property (nonatomic,weak) id <DataHelperDelegate> delegate;
@property (nonatomic,weak) id <DataHelperDataSource> dataSource;

- (void)loadData;
- (void)loadMoreData;
- (void)reloadData;

/// For sub classes override
- (BOOL)reloadDataAtLoginStatusChanged;
- (BOOL)reloadDataAtNetworkReconnect;

 /// Shortcut for helper.entity.propertyName
- (ResponseStatus)status;
- (NSString *)message;
- (NSInteger)currentPage;
- (BOOL)hasNoMoreData;
- (NSMutableArray *)totalPageModels;

@end

#pragma mark -
@protocol DataHelperDataSource <NSObject>

- (RootApi *)apiForDataHelper:(LLDataHelper *)helper;

@end

#pragma mark -
@protocol DataHelperDelegate <NSObject>

- (void)loadDataSucceed:(LLDataHelper *)helper;
- (void)loadDataFailed:(LLDataHelper *)helper;
- (void)dataHelper:(LLDataHelper *)helper requestError:(YTKBaseRequest *)request;

@end
