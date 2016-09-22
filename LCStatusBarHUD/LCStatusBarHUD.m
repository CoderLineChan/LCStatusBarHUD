//
//  LCStatusBarHUD.m
//  LCStatusBarHUDDemo
//
//  Created by 陈连辰 on 16/9/21.
//  Copyright © 2016年 linechen. All rights reserved.
//  https://github.com/CoderLineChan/LCStatusBarHUD

#import "LCStatusBarHUD.h"

/** HUD的背景颜色 */
#define LCBackgroundColor [UIColor colorWithRed:0.2715 green:0.2715 blue:0.2715 alpha:1.0]

@implementation LCStatusBarHUD

/** 显示字体大小 */
static CGFloat LCTitleFont = 13;
/** HUD显示的总时间 */
static CGFloat LCStatusDuration = 2.0;
/** HUD出现与消失的时间 */
static CGFloat LCAnimationDuration = 0.25;
/** 图片与文字的间距 */
static CGFloat LCTitleImageMargin = 10;
/** 图片与菊花的间距 */
static CGFloat LCTitleIndicatorViewMargin = 20;

/** 定时器 */
static NSTimer *_timer;

/** 显示的窗口 */
static UIWindow *_window;

#pragma mark - 公共方法
/**
 *  显示文字
 */
+ (void)showMessage:(NSString *)text{
    [self setWindow:text andImage:nil withIndicatorView:NO];
    [self startTimer];
    
}
/**
 *  显示文字与图片
 */
+ (void)showMessage:(NSString *)text image:(UIImage *)image{
    [self setWindow:text andImage:image withIndicatorView:NO];
    [self startTimer];
}
/**
 *  显示成功信息
 */
+ (void)showSuccess:(NSString *)text{
    [self setWindow:text andImage:[UIImage imageNamed:@"LCStatusBarHUD.bundle/success"] withIndicatorView:NO];
    [self startTimer];
}
/**
 *  显示失败信息
 */
+ (void)showError:(NSString *)text{
    [self setWindow:text andImage:[UIImage imageNamed:@"LCStatusBarHUD.bundle/error"] withIndicatorView:NO];
    [self startTimer];
}
/**
 *  显示正在加载信息
 */
+ (void)showLoading:(NSString *)text{
    [_timer invalidate];
    [self setWindow:text andImage:nil withIndicatorView:YES];
}
/**
 *  隐藏指示器
 */
+ (void)dismiss{
    [_timer invalidate];
    _timer = nil;
    [UIView animateWithDuration:LCAnimationDuration animations:^{
        CGRect beginAnima = _window.frame;
        beginAnima.origin.y = -beginAnima.size.height;
        _window.frame = beginAnima;
    }completion:^(BOOL finished) {
        if (_timer == nil) {
            _window.hidden = YES;
            _window = nil;
        }
    }];
}
#pragma mark - 私有方法
/**
 *  初始化窗口
 */
+ (void)setWindow:(NSString *)text andImage:(UIImage *)image withIndicatorView:(BOOL)isLoadView{
    // window的设置
    CGRect windowF = [[UIApplication sharedApplication] statusBarFrame];
    _window = [[UIWindow alloc] init];
    _window.frame = windowF;
    _window.backgroundColor = LCBackgroundColor;
    _window.hidden = NO;
    _window.windowLevel = UIWindowLevelAlert;
    
    // 按钮的设置
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = _window.bounds;
    [btn setTitle:text forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:LCTitleFont];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    CGRect btnTextRect = [btn.titleLabel.text boundingRectWithSize:windowF.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:btn.titleLabel.font} context:nil];
    [btn.titleLabel sizeToFit];
    if (image) {
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, LCTitleImageMargin, 0, 0)];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, LCTitleImageMargin)];
    }
    [_window addSubview:btn];
    
    // 菊花的设置
    UIActivityIndicatorView *loadView = [[UIActivityIndicatorView alloc] init];
    CGFloat btnTextW = btnTextRect.size.width;
    CGFloat loadViewCenterX = (_window.frame.size.width - btnTextW) * 0.5 - LCTitleIndicatorViewMargin;
    CGFloat loadViewCenterY = _window.frame.size.height * 0.5;
    loadView.center = CGPointMake(loadViewCenterX, loadViewCenterY);
    [loadView startAnimating];
    if (isLoadView) {
        [_window addSubview:loadView];
    }
    
    
    // 动画效果 从顶部出现
    CGRect beginAnima = windowF;
    beginAnima.origin.y = -beginAnima.size.height;
    _window.frame = beginAnima;
    [UIView animateWithDuration:LCAnimationDuration animations:^{
        _window.frame = windowF;
    }];
}
/**
 *  开始自动计时
 */
+ (void)startTimer{
    [_timer invalidate];
    _timer = [NSTimer scheduledTimerWithTimeInterval:LCStatusDuration target:self selector:@selector(dismiss) userInfo:nil repeats:NO];
}


@end
