//
//  BestListImageCell.m
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/31.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#import "BestListImageCell.h"
#import "TextStyle.h"
#import "BestListCellModel.h"

@interface BestListImageCell () <ASNetworkImageNodeDelegate>

@property (strong, nonatomic) ASNetworkImageNode *imageNode;
@property (strong, nonatomic) ASButtonNode *indocator;

@end

@implementation BestListImageCell

- (instancetype)initWithModel:(BestListCellModel *)model
{
    self = [super initWithModel:model];
    if (self)
    {
        // Image
        NSString *url = @"";
        if (model.image3) url = model.image3;
        else if (model.image2) url = model.image2;
        else if (model.image1) url = model.image1;
        else if (model.image0) url = model.image0;
        
        _imageNode = [[ASNetworkImageNode alloc] init];
        _imageNode.delegate = self;
        _imageNode.URL = [NSURL URLWithString:url];
        _imageNode.backgroundColor = ASDisplayNodeDefaultPlaceholderColor();
        _imageNode.imageModificationBlock = ^UIImage *(UIImage *image) {
            
            UIImage *modifiedImage;
            CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
            UIGraphicsBeginImageContextWithOptions(image.size, false, [[UIScreen mainScreen] scale]);
            [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:0] addClip];
            [image drawInRect:rect];
            modifiedImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return modifiedImage;
        };
        [self addSubnode:_imageNode];
        
        // indicator of long image
        _indocator = [[ASButtonNode alloc] init];
        NSAttributedString *string = [[NSAttributedString alloc] initWithString:@"点击查看全图" attributes:[TextStyle longImgIndicatorStyle]];
        [_indocator setAttributedTitle:string forState:0];
        [_indocator setImage:[UIImage imageNamed:@"full"] forState:0];
        _indocator.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        _indocator.style.height = ASDimensionMakeWithPoints(44);
        _indocator.hidden = YES;
        [self addSubnode:_indocator];
    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    // Super
    ASLayoutSpec *superSpec = [super layoutSpecThatFits:constrainedSize];
    
    // Image
    CGFloat ratio = 1;
    if (self.model.width > 0 && self.model.height > 0)
    {
        CGFloat tempRatio = self.model.height / self.model.width;
        // The critical value which determines the ImageNode is long or not
        int criticalValue = 4;
        _indocator.hidden = tempRatio <= criticalValue;
        // The ImageNode's real ratio to display
        ratio = tempRatio <= criticalValue ? tempRatio : ratio;
    }
    ASRatioLayoutSpec *imageSpec = [ASRatioLayoutSpec ratioLayoutSpecWithRatio:ratio child:_imageNode];
    
    // Cover the indicator to the ImageSpec
    ASInsetLayoutSpec *indicatorSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(INFINITY, 0, 0, 0) child:_indocator];
    ASOverlayLayoutSpec *overlaySpec = [ASOverlayLayoutSpec overlayLayoutSpecWithChild:imageSpec overlay:indicatorSpec];
    
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

#pragma mark - ASNetworkImageNodeDelegate methods.

- (void)imageNode:(ASNetworkImageNode *)imageNode didLoadImage:(UIImage *)image
{
    self.model.width = image.size.width;
    self.model.height = image.size.height;
    [self setNeedsLayout];
}

@end
