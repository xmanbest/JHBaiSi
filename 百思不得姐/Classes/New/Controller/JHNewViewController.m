//
//  JHNewViewController.m
//  百思不得姐
//
//  Created by 李建華 on 16/3/24.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import "JHNewViewController.h"

@implementation JHNewViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置背景色
    self.view.backgroundColor = JHGlobalBackColore;
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    // 设置导航栏按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightImage:@"MainTagSubIconClick" target:self action:@selector(tagClick:)];
    
}

- (void)tagClick:(UIButton *)btn {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];

}
@end
