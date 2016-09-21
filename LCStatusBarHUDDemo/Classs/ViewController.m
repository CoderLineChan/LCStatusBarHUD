//
//  ViewController.m
//  LCStatusBarHUDDemo
//
//  Created by 陈连辰 on 16/9/21.
//  Copyright © 2016年 linechen. All rights reserved.
//

#import "ViewController.h"
#import "LCStatusBarHUD.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
- (IBAction)success {
    [LCStatusBarHUD showSuccess:@"成功"];
}
- (IBAction)error {
    [LCStatusBarHUD showError:@"失败"];
}
- (IBAction)loading {
    [LCStatusBarHUD showLoading:@"正在加载..."];
}
- (IBAction)disimiss {
    [LCStatusBarHUD dismiss];
}

@end
