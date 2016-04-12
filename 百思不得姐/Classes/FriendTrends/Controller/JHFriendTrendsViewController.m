//
//  JHFriendTrendsViewController.m
//  百思不得姐
//
//  Created by 李建華 on 16/3/24.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import "JHFriendTrendsViewController.h"
#import "JHRecommendViewController.h"
#import "JHLoginRegisterViewController.h"

@implementation JHFriendTrendsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置背景色
    self.view.backgroundColor = JHGlobalBackColore;
    // 设置导航栏标题
    self.navigationItem.title = @"我的关注";
    // 设置导航栏按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highlightImage:@"friendsRecommentIcon-click" target:self action:@selector(friendClick:)];
    
}

- (void)friendClick:(UIButton *)btn {
    UIViewController *vc = [[JHRecommendViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)loginBtnClick:(id)sender {
    JHLoginRegisterViewController *vc = [[JHLoginRegisterViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}


@end
