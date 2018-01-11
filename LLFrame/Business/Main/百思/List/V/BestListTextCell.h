//
//  BestListTextCell.h
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/31.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@class BestListCellModel;

@interface BestListTextCell : ASCellNode

@property (nonatomic,strong) BestListCellModel *model;

- (instancetype)initWithModel:(BestListCellModel *)model;

@end
