//
//  LCStatusBarHUD.h
//  LCStatusBarHUDDemo
//
//  Created by 陈连辰 on 16/9/21.
//  Copyright © 2016年 linechen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCStatusBarHUD : NSObject

/**
 *  显示成功信息
 */
+ (void)showSuccess:(NSString *)text;

/**
 *  显示失败信息
 */
+ (void)showError:(NSString *)text;

/**
 *  显示菊花载信息
 */
+ (void)showLoading:(NSString *)text;

/**
 *  隐藏指示器
 */
+ (void)dismiss;

/**
 *  显示文字
 */
+ (void)showMessage:(NSString *)text;

/**
 *  显示文字与图片
 */
+ (void)showMessage:(NSString *)text image:(UIImage *)image;
@end
