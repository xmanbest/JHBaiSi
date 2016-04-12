//
//  JHTabBarController.m
//  百思不得姐
//
//  Created by 李建華 on 16/3/24.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import "JHTabBarController.h"
#import "JHEssenceViewController.h"
#import "JHNewViewController.h"
#import "JHFriendTrendsViewController.h"
#import "JHMeViewController.h"
#import "JHTabBar.h"
#import "JHNavigationController.h"
#import <SVProgressHUD.h>

@implementation JHTabBarController
+ (void)initialize {
    [super initialize];
    
    // 设置UITabBarItem统一appearance外观
    UITabBarItem *tbi = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self.class]];
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor grayColor];
    NSMutableDictionary *selAttr = [NSMutableDictionary dictionary];
    selAttr[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [tbi setTitleTextAttributes:attr forState:UIControlStateNormal];
    [tbi setTitleTextAttributes:selAttr forState:UIControlStateSelected];
    
    // 设置等待菊花统一样式
    [[SVProgressHUD appearance] setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [[SVProgressHUD appearance] setDefaultStyle:SVProgressHUDStyleDark];
    [[SVProgressHUD appearance] setMinimumDismissTimeInterval:2];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置子控制器
    [self setupChildVC:[[JHEssenceViewController alloc] init] withTitle:@"精华" image:@"tabBar_essence_icon" selImage:@"tabBar_essence_click_icon"];
    [self setupChildVC:[[JHNewViewController alloc] init] withTitle:@"新帖" image:@"tabBar_new_icon" selImage:@"tabBar_new_click_icon"];
    [self setupChildVC:[[JHFriendTrendsViewController alloc] init] withTitle:@"关注" image:@"tabBar_friendTrends_icon" selImage:@"tabBar_friendTrends_click_icon"];
    [self setupChildVC:[[JHMeViewController alloc] init] withTitle:@"我" image:@"tabBar_me_icon" selImage:@"tabBar_me_click_icon"];
    
    // 自定义tabBar
    [self setValue:[[JHTabBar alloc] init] forKeyPath:@"tabBar"];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    NSLog(@"%@", self.tabBar.subviews);
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    NSLog(@"%@", self.tabBar.subviews);
}

/**
 *  设置子控制器属性
 */
- (void)setupChildVC:(UIViewController *)vc withTitle:(NSString *)title image:(NSString *)image selImage:(NSString *)selImage {
    vc.tabBarItem.title = title;
    vc.navigationItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *nc = [[JHNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nc];
}
@end
