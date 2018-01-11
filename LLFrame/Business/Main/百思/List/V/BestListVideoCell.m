//
//  BestListVideoCell.m
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/31.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#import "BestListVideoCell.h"
#import "TextStyle.h"
#import "BestListCellModel.h"

@interface BestListVideoCell ()

@property (strong, nonatomic) ASVideoNode *videoNode;
@property (strong, nonatomic) ASButtonNode *playNode;

@end

@implementation BestListVideoCell

- (instancetype)initWithModel:(BestListCellModel *)model
{
    self = [super initWithModel:model];
    if (self)
    {
        // Video
        _videoNode = [[ASVideoNode alloc] init];
        _videoNode.asset = [AVAsset assetWithURL:[NSURL URLWithString:model.video_uri]];
        _videoNode.backgroundColor = ASDisplayNodeDefaultPlaceholderColor();
        [self addSubnode:_videoNode];
        
        // Play button
        _playNode = [[ASButtonNode alloc] init];
        [_playNode setImage:[UIImage imageNamed:@"play"] forState:0];
        [self addSubnode:_playNode];
    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    // Super
    ASLayoutSpec *superSpec = [super layoutSpecThatFits:constrainedSize];
    
    // Video
    ASRatioLayoutSpec *videoSpec = [ASRatioLayoutSpec ratioLayoutSpecWithRatio:0.57 child:_videoNode];
    
    // Cover the Play button to the Video
    ASInsetLayoutSpec *playSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsZero child:_playNode];
    ASOverlayLayoutSpec *overlaySpec = [ASOverlayLayoutSpec overlayLayoutSpecWithChild:videoSpec overlay:playSpec];
    
    // Add insets to the OverlaySpec
    UIEdgeInsets overlayInsets = UIEdgeInsetsMake(0, 15, 13, 15);
    ASInsetLayoutSpec *overlayInsetsSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:overlayInsets child:overlaySpec];
    
    // Content (Super and Image)
    NSArray *contentSpecChildren = @[superSpec, overlayInsetsSpec];
    ASStackLayoutSpec *contentSpec =
    [ASStackLayoutSpec
     stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
     spacing:0
     justifyContent:ASStackLayoutJustifyContentStart
     alignItems:ASStackLayoutAlignItemsStretch
     children:contentSpecChildren];
    
    return contentSpec;
}

@end
