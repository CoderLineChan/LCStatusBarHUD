//
//  LCStatusBarHUD.h
//  LCStatusBarHUDDemo
//
//  Created by 陈连辰 on 16/9/21.
//  Copyright © 2016年 linechen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCStatusBarHUD : NSObject


+ (void)showSuccess:(NSString *)text;
+ (void)showError:(NSString *)text;
+ (void)showLoading:(NSString *)text;
+ (void)dismiss;

+ (void)showText:(NSString *)text;
+ (void)showText:(NSString *)text image:(UIImage *)image;
@end
