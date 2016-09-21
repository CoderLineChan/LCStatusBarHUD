//
//  LCStatusBarHUD.m
//  LCStatusBarHUDDemo
//
//  Created by 陈连辰 on 16/9/21.
//  Copyright © 2016年 linechen. All rights reserved.
//

#import "LCStatusBarHUD.h"

@implementation LCStatusBarHUD

static CGFloat LCTitleFont = 14;
static CGFloat LCStatusDuration = 2.0;
static CGFloat LCAnimationDuration = 0.25;
static CGFloat LCTitleImageMargin = 10;

static NSTimer *_timer;
static UIWindow *_window;

+ (void)setWindow:(NSString *)text andImage:(UIImage *)image{
    CGRect windowF = [[UIApplication sharedApplication] statusBarFrame];
    _window = [[UIWindow alloc] init];
    _window.frame = windowF;
    _window.backgroundColor = [UIColor grayColor];
    _window.hidden = NO;
    _window.windowLevel = UIWindowLevelAlert;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = _window.bounds;
    [btn setTitle:text forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:LCTitleFont];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    if (image) {
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, LCTitleImageMargin, 0, 0)];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, LCTitleImageMargin)];
    }
    [_window addSubview:btn];
    CGRect beginAnima = windowF;
    beginAnima.origin.y = -beginAnima.size.height;
    _window.frame = beginAnima;
    [UIView animateWithDuration:LCAnimationDuration animations:^{
        _window.frame = windowF;
    }completion:^(BOOL finished) {
        [_timer invalidate];
        _timer = [NSTimer scheduledTimerWithTimeInterval:LCStatusDuration target:self selector:@selector(dismiss) userInfo:nil repeats:NO];
    }];
    
    
}
+ (void)showText:(NSString *)text{
    [self setWindow:text andImage:nil];
}
+ (void)showText:(NSString *)text image:(UIImage *)image{
    [self setWindow:text andImage:image];
}

+ (void)showSuccess:(NSString *)text{
    [self setWindow:text andImage:[UIImage imageNamed:@"LCStatusBarHUD.bundle/success"]];
    
    
}
+ (void)showError:(NSString *)text{
    [self setWindow:text andImage:[UIImage imageNamed:@"LCStatusBarHUD.bundle/error"]];
    
}
+ (void)showLoading:(NSString *)text{
    
}
+ (void)dismiss{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect beginAnima = _window.frame;
        beginAnima.origin.y = -beginAnima.size.height;
        _window.frame = beginAnima;
    }completion:^(BOOL finished) {
        _window.hidden = YES;
        _window = nil;
    }];
}

@end
