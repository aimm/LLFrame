//
//  LLEmptyHelper.m
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/6.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import "LLEmptyHelper.h"

@interface LLEmptyHelper () 

@property (nonatomic,strong) NSMutableDictionary *titles;
@property (nonatomic,strong) NSMutableDictionary *descriptions;
@property (nonatomic,strong) NSMutableDictionary *images;
@property (nonatomic,strong) NSMutableDictionary *buttonImages;

@end

@implementation LLEmptyHelper

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.status = ResponseStatusDefault;
        
        // 默认样式 只有一个描述语
        [self setTitle:@"" forStatus:ResponseStatusDefault];
        [self setDescription:@"加载中..." forStatus:ResponseStatusDefault];
        
        // 请求成功
        [self setTitle:@"暂无相关内容" forStatus:ResponseStatusSuccess];
        [self setDescription:@"这里空空如也，逛逛其他页面吧~" forStatus:ResponseStatusSuccess];
        [self setImage:[UIImage imageNamed:@"list_empty"] forStatus:ResponseStatusSuccess];
        
        // 请求失败
        [self setTitle:@"出了点小问题" forStatus:ResponseStatusFail];
        [self setDescription:@"联系客服，说不定能帮您解决~" forStatus:ResponseStatusFail];
        [self setImage:[UIImage imageNamed:@"load_failed_empty"] forStatus:ResponseStatusFail];
        
        // 请求出错
        [self setTitle:@"网络请求失败" forStatus:ResponseStatusError];
        [self setDescription:@"请检查您的网络，重新加载吧" forStatus:ResponseStatusError];
        [self setImage:[UIImage imageNamed:@"net_disconnected"] forStatus:ResponseStatusError];
        
        // 网络请求失败的带 重新加载 的按钮
        UIImage *netDisconnectedButtonImage = nil;
        NSString *netDisconnectedButtonImageKey = @"netDisconnectedButtonImageKey";
        if ([[YYImageCache sharedCache] containsImageForKey:netDisconnectedButtonImageKey])
        {
            netDisconnectedButtonImage = [[YYImageCache sharedCache] getImageForKey:netDisconnectedButtonImageKey];
        }
        else
        {
            netDisconnectedButtonImage = [[UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(AdaptedWidth(120), AdaptedHeight(34))] imageByRoundCornerRadius:3 borderWidth:0.5 borderColor:[UIColor flatBlackColor]];
            [[YYImageCache sharedCache] setImage:netDisconnectedButtonImage forKey:netDisconnectedButtonImageKey];
        }
        [self setButtonImage:netDisconnectedButtonImage forStatus:ResponseStatusError];
    }
    return self;
}

- (void)setImage:(UIImage *)image forStatus:(ResponseStatus)status
{
    [self.images setObject:image forKey:@(status)];
}

- (void)setTitle:(NSString *)title forStatus:(ResponseStatus)status
{
    [self.titles setObject:title forKey:@(status)];
}

- (void)setDescription:(NSString *)description forStatus:(ResponseStatus)status
{
    [self.descriptions setObject:description forKey:@(status)];
}

- (void)setButtonImage:(UIImage *)image forStatus:(ResponseStatus)status
{
    [self.buttonImages setObject:image forKey:@(status)];
}

#pragma mark - Empty data source

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    UIImage *image = nil;
    
    if ([self.images.allKeys containsObject:@(self.status)])
    {
        image = self.images[@(self.status)];
    }
    
    return image;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    // Styles
    NSMutableDictionary *atts = [NSMutableDictionary new];
    atts[NSFontAttributeName] = AdaptedFontSize(18);
    atts[NSForegroundColorAttributeName] = rgb(170, 170, 170);
    
    NSAttributedString *emptyAttTitle = [[NSAttributedString alloc] initWithString:self.titles[@(self.status)] attributes:atts];
    
    return emptyAttTitle;
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    // Styles
    NSMutableDictionary *atts = [NSMutableDictionary new];
    atts[NSFontAttributeName] = AdaptedFontSize(13.5);
    atts[NSForegroundColorAttributeName] = rgb(170, 170, 170);
    
    NSAttributedString *emptyAttDesc = [[NSAttributedString alloc] initWithString:self.descriptions[@(self.status)] attributes:atts];
    
    return emptyAttDesc;
}

- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    UIImage *image = nil;
    
    if ([self.buttonImages.allKeys containsObject:@(self.status)])
    {
        image = self.buttonImages[@(self.status)];
    }
    
    return image;
}

#pragma mark - Empty delegate

- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView
{
    scrollView.contentOffset = CGPointZero;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button;
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickedEmptyButton:)])
    {
        [self.delegate didClickedEmptyButton:self];
    }
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickedEmptyView:)])
    {
        [self.delegate didClickedEmptyView:self];
    }
}

#pragma mark - Lazy

- (NSMutableDictionary *)titles
{
    if (!_titles)
    {
        _titles = [NSMutableDictionary new];
    }
    return _titles;
}

- (NSMutableDictionary *)descriptions
{
    if (!_descriptions)
    {
        _descriptions = [NSMutableDictionary new];
    }
    return _descriptions;
}

- (NSMutableDictionary *)images
{
    if (!_images)
    {
        _images = [NSMutableDictionary new];
    }
    return _images;
}

- (NSMutableDictionary *)buttonImages
{
    if (!_buttonImages)
    {
        _buttonImages = [NSMutableDictionary new];
    }
    return _buttonImages;
}

@end
