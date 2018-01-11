//
//  UIButton+LLAdd.m
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/1.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import "UIButton+LLAdd.h"

static NSString *const kIndicatorViewKey = @"indicatorView";
static NSString *const kButtonTextObjectKey = @"buttonTextObject";

@implementation UIButton (LLAdd)

#pragma mark - 倒计时
-(void)startTime:(NSInteger )timeout
       waitTitle:(NSString *)waitTitle
        endTitle:(NSString *)endTitle;
{
    __block NSInteger timeOut = timeout; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeOut <= 0)
        {
            //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setTitle:endTitle forState:UIControlStateNormal];
                self.enabled = YES;
            });
            self.isCountDown = @"0";
        }
        else
        {
            self.isCountDown = @"1";
            
            NSString *strTime = [NSString stringWithFormat:@"%lds", (long)timeOut];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.enabled = NO;
                
                //设置界面的按钮显示 根据自己需求设置
                [self setTitle:[NSString stringWithFormat:@"%@%@",strTime,waitTitle] forState:0];
                
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}

- (void)setIsCountDown:(NSString *)isCountDown
{
    objc_setAssociatedObject(self, @selector(isCountDown), isCountDown, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)isCountDown
{
    return objc_getAssociatedObject(self, @selector(isCountDown));
}

#pragma mark - 展示菊花
- (void)showIndicator
{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [indicator startAnimating];
    
    NSString *currentButtonText = self.titleLabel.text;
    
    objc_setAssociatedObject(self, &kButtonTextObjectKey, currentButtonText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &kIndicatorViewKey, indicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self setTitle:@"" forState:UIControlStateNormal];
    self.enabled = NO;
    [self addSubview:indicator];
    indicator.sd_layout
    .centerYEqualToView(self)
    .centerXEqualToView(self);
}

#pragma mark - 隐藏菊花
- (void)hideIndicator
{
    NSString *currentButtonText = (NSString *)objc_getAssociatedObject(self, &kButtonTextObjectKey);
    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)objc_getAssociatedObject(self, &kIndicatorViewKey);
    
    [indicator removeFromSuperview];
    [self setTitle:currentButtonText forState:UIControlStateNormal];
    
    self.enabled = YES;
}

@end
