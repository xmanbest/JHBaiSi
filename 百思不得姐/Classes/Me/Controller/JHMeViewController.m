//
//  JHMeViewController.m
//  百思不得姐
//
//  Created by 李建華 on 16/3/24.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import "JHMeViewController.h"

@implementation JHMeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置背景色
    self.view.backgroundColor = JHGlobalBackColore;
    // 设置导航栏标题
    self.navigationItem.title = @"我的";
    
    // 设置导航栏按钮    
    UIBarButtonItem *settingBtn = self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highlightImage:@"mine-setting-icon-click" target:self action:@selector(settingClick:)];
    UIBarButtonItem *moonBtn = self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highlightImage:@"mine-moon-icon-click" target:self action:@selector(moonClick:)];
    
    self.navigationItem.rightBarButtonItems = @[
                                            settingBtn,
                                            moonBtn
                                                ];
}

- (void)settingClick:(UIButton *)btn {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)moonClick:(UIButton *)btn {
    JHLog(@"moonClick");
}
@end
