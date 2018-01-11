//
//  BestListApi.h
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/31.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#import "RootApi.h"
#import "ListType.h"

@interface BestListApi : RootApi

- (instancetype)initWithType:(ListType)type currentPage:(NSInteger)currentPage;

@end
