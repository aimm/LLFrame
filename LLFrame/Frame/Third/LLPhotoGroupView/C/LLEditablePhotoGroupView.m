//
//  LLEditablePhotoGroupView.m
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/1.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import "LLEditablePhotoGroupView.h"
#import <CHTCollectionViewWaterfallLayout/CHTCollectionViewWaterfallLayout.h>
#import "LLPhotoGroupCell.h"
#import "LLPhotoGroupAddCell.h"
#import "PhotoBrowserHelper.h"
#import "PhotoPickerHelper.h"
#import "LLPhoto.h"

static NSString * NormalCellReuseId = @"NormalCellReuseId";
static NSString * AddCellReuseId = @"AddCellReuseId";

@interface LLEditablePhotoGroupView () <UICollectionViewDelegate,UICollectionViewDataSource,CHTCollectionViewDelegateWaterfallLayout,LLPhotoPickerDelegate,LLPhotoGroupCellDelegate>

@property (nonatomic,strong) CHTCollectionViewWaterfallLayout *layout;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) PhotoPickerHelper *imagePickerHelper;
@property (nonatomic,assign) NSInteger selectedCount;

@end


@implementation LLEditablePhotoGroupView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
