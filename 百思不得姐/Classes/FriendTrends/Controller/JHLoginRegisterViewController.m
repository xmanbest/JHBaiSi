//
//  JHLoginRegisterViewController.m
//  百思不得姐
//
//  Created by 李建華 on 16/3/30.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import "JHLoginRegisterViewController.h"

@interface JHLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
/**
 *  登录框左边界距离父框体左边界约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginLeadingToSuperLeading;

@end

@implementation JHLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view insertSubview:self.backgroundImageView atIndex:0];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

/**
 *  点击登录注册切换按钮
 */
- (IBAction)registerLoginSwitch:(UIButton *)sender {
    // 退出键盘
    [self.view endEditing:YES];
    
    if (self.loginLeadingToSuperLeading.constant == 0) { // 当前显示登录框
        // 显示注册框
        self.loginLeadingToSuperLeading.constant = -self.view.width;
        // 按钮文字变化
        [sender setTitle:@"登录账号" forState:UIControlStateNormal];
    } else { // 当前显示注册框
        // 显示登录框
        self.loginLeadingToSuperLeading.constant = 0;
        // 按钮文字变化
        [sender setTitle:@"注册账号" forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        // 更改约束参数后，在下次重绘前立即刷新子视图布局
        [self.view layoutIfNeeded];
    }];

}

/**
 *  点击关闭按钮
 */
- (IBAction)closeBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
