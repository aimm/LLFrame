//
//  BestListDataEntity.m
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/5.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import "BestListDataEntity.h"
#import "BestListCellModel.h"

@implementation BestListDataEntity

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"currentPageModels" : [BestListCellModel class]};
}

@end
