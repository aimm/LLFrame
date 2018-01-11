//
//  LLEmptyHelper.h
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/6.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import "RootModel.h"
#import "LLDataEntity.h"
#import "UIScrollView+EmptyDataSet.h"

@protocol LLEmptyDelegate;

/**
 空页面帮助类
 提前设置好各种状态下的空样式，通过修改 emptyHelper 的 status 以展示不同的空内容
 NOTE：如果不设置则显示此状态下默认的空样式
 */
@interface LLEmptyHelper : RootModel <DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

- (void)setImage:(UIImage *)image forStatus:(ResponseStatus)status;
- (void)setTitle:(NSString *)title forStatus:(ResponseStatus)status;
- (void)setDescription:(NSString *)description forStatus:(ResponseStatus)status;
- (void)setButtonImage:(UIImage *)image forStatus:(ResponseStatus)status;

@property (nonatomic,assign) ResponseStatus status;
@property (nonatomic,weak) id <LLEmptyDelegate> delegate;

@end

@protocol LLEmptyDelegate <NSObject>

- (void)didClickedEmptyButton:(LLEmptyHelper *)emptyHelper;
- (void)didClickedEmptyView:(LLEmptyHelper *)emptyHelper;

@end
