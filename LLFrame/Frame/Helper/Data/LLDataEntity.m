//
//  LLDataEntity.m
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/5.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import "LLDataEntity.h"

@implementation LLDataEntity

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.status = ResponseStatusDefault;
        self.message = @"";
        self.currentPage = 0;
        self.totalPage = 1;
    }
    return self;
}

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{
             @"status" : @[@"status", @"showapi_res_code"],
             @"message" : @[@"message", @"showapi_res_error"],
             @"currentPage" : @[@"currentPage", @"showapi_res_body.pagebean.currentPage"],
             @"totalPage" : @[@"totalPage", @"showapi_res_body.pagebean.allPages"],
             @"currentPageModels" : @[@"currentPageModels",@"list", @"showapi_res_body.pagebean.contentlist"],
             };
}

- (void)handleData
{
    if (self.status == ResponseStatusSuccess)
    {
        // 下拉刷新清空
        if (self.currentPage == 1 && self.totalPageModels.count > 0)
        {
            [self.totalPageModels removeAllObjects];
        }
        
        // 添加数据
        [self.totalPageModels addObjectsFromArray:self.currentPageModels];
    }
}

- (NSMutableArray *)totalPageModels
{
    if (!_totalPageModels)
    {
        _totalPageModels = [NSMutableArray new];
    }
    return _totalPageModels;
}

@end
