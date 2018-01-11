//
//  BestListTextCell.m
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/31.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#import "BestListTextCell.h"
#import "TextStyle.h"
#import "BestListCellModel.h"

@interface BestListTextCell ()

@property (strong, nonatomic) ASNetworkImageNode *avatarNode;
@property (strong, nonatomic) ASTextNode *nameNode;
@property (strong, nonatomic) ASTextNode *timeNode;
@property (strong, nonatomic) ASTextNode *postNode;

@end

@implementation BestListTextCell

- (instancetype)initWithModel:(BestListCellModel *)model
{
    self = [super init];
    if (self)
    {
        _model = model;
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // Avatar
        int avatarRect = 30;
        _avatarNode = [[ASNetworkImageNode alloc] init];
        _avatarNode.backgroundColor = ASDisplayNodeDefaultPlaceholderColor();
        _avatarNode.style.width = ASDimensionMakeWithPoints(avatarRect);
        _avatarNode.style.height = ASDimensionMakeWithPoints(avatarRect);
        _avatarNode.cornerRadius = avatarRect * 0.5;
        _avatarNode.URL = [NSURL URLWithString:model.profile_image];
        _avatarNode.imageModificationBlock = ^UIImage *(UIImage *image) {
            
            UIImage *modifiedImage;
            CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
            
            UIGraphicsBeginImageContextWithOptions(image.size, false, [[UIScreen mainScreen] scale]);
            
            [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:avatarRect] addClip];
            [image drawInRect:rect];
            modifiedImage = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            
            return modifiedImage;
            
        };
        [self addSubnode:_avatarNode];
        
        // Name
        _nameNode = [[ASTextNode alloc] init];
        _nameNode.attributedText = [[NSAttributedString alloc] initWithString:model.name attributes:[TextStyle nameStyle]];
        _nameNode.maximumNumberOfLines = 1;
        [self addSubnode:_nameNode];
        
        // Time
        _timeNode = [[ASTextNode alloc] init];
        _timeNode.attributedText = [[NSAttributedString alloc] initWithString:model.create_time attributes:[TextStyle timeStyle]];
        _timeNode.maximumNumberOfLines = 1;
        [self addSubnode:_timeNode];
        
        // Post text
        _postNode = [[ASTextNode alloc] init];
        _postNode.attributedText = [[NSAttributedString alloc] initWithString:model.filteredText attributes:[TextStyle postStyle]];
        [self addSubnode:_postNode];
    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    // Name (name and time)
    NSArray *nameLayoutChildren = @[_nameNode, _timeNode];
    ASStackLayoutSpec *nameStack =
    [ASStackLayoutSpec
     stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
     spacing:3
     justifyContent:ASStackLayoutJustifyContentCenter
     alignItems:ASStackLayoutAlignItemsStart
     children:nameLayoutChildren];
    nameStack.style.alignSelf = ASStackLayoutAlignSelfStretch;
    
    // Title (avatar and Name)
    NSArray *titleLayoutChildren = @[_avatarNode, nameStack];
    ASStackLayoutSpec *titleStack =
    [ASStackLayoutSpec
     stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
     spacing:10
     justifyContent:ASStackLayoutJustifyContentStart
     alignItems:ASStackLayoutAlignItemsCenter
     children:titleLayoutChildren];
    titleStack.style.alignSelf = ASStackLayoutAlignSelfStretch;
    
    // Content (Title and text)
    NSArray *contentStackChildren = @[titleStack, _postNode];
    ASStackLayoutSpec *contentStack =
    [ASStackLayoutSpec
     stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
     spacing:13
     justifyContent:ASStackLayoutJustifyContentStart
     alignItems:ASStackLayoutAlignItemsStretch
     children:contentStackChildren];
    contentStack.style.flexShrink = 1.0;
    
    ASInsetLayoutSpec *spec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 15, 13, 15) child:contentStack];
    
    return spec;
}

@end
