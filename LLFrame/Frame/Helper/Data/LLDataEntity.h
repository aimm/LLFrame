//
//  LLDataEntity.h
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/5.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import "RootModel.h"

/**
 响应状态码

 - ResponseStatusDefault: 默认
 - ResponseStatusSuccess: 成功，请求成功且服务器返回状态码为成功
 - ResponseStatusFail: 失败，请求成功但是返回的状态码为失败
 - ResponseStatusError: 出错，请求失败，如请求地址404、500
 */
typedef NS_ENUM(NSInteger, ResponseStatus) {
    ResponseStatusDefault = -10086,
    ResponseStatusSuccess = 0,
    ResponseStatusFail = 1,
    ResponseStatusError,
};

@interface LLDataEntity : RootModel

@property (nonatomic,assign) ResponseStatus status;
@property (nonatomic,copy)   NSString *message;

@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,assign) NSInteger totalPage;

@property (nonatomic,strong) NSArray *currentPageModels;
@property (nonatomic,strong) NSMutableArray *totalPageModels;

@property (nonatomic,assign) BOOL hasNoMoreData;

- (void)handleData;

@end
