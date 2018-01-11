//
//  BestListCellModel.m
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/31.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#import "BestListCellModel.h"

@implementation BestListCellModel

- (NSString *)filteredText
{
    if (!_filteredText)
    {
        _filteredText = [self.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    return _filteredText;
}

@end
