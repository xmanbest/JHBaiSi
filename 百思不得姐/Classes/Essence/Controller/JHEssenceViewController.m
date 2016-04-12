//
//  JHEssenceViewController.m
//  百思不得姐
//
//  Created by 李建華 on 16/3/24.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import "JHEssenceViewController.h"
#import "JHRecommendTagViewController.h"
#import "JHTopicViewController.h"

@interface JHEssenceViewController () <UIScrollViewDelegate>
/**
 *  头部视图
 */
@property(nonatomic, weak)UIView *headView;
/**
 *  头部按钮选中指示器
 */
@property(nonatomic, weak)UIView *selIndicator;
/**
 *  头部当前选中按钮
 */
@property(nonatomic, weak)UIButton *currentSelHeadBtn;
/**
 *  放置内容的滚动区域
 */
@property(nonatomic, weak)UIScrollView *contentScrollView;
@end

@implementation JHEssenceViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 基本设置
    [self setup];
    // 设置子控制器
    [self setupChildVC];
    // 设置头部
    [self setupHead];
    // 设置内容部分
    [self setupContent];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 默认头部选择第一个按钮
    [self headBtnClick:self.headView.subviews[0]];
}
/**
 *  基本设置
 */
- (void)setup {
    // 设置背景色
    self.view.backgroundColor = JHGlobalBackColore;
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    // 设置导航栏按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightImage:@"MainTagSubIconClick" target:self action:@selector(tagClick:)];
    // 禁止自动调节顶部缩进
    self.automaticallyAdjustsScrollViewInsets = NO;
}
/**
 *  设置子控制器
 */
- (void)setupChildVC {
    JHTopicViewController *allVC = [[JHTopicViewController alloc] init];
    allVC.title = @"推荐";
    allVC.topicType = JHTopicTypeAll;
    [self addChildViewController:allVC];
    
    JHTopicViewController *videoVC = [[JHTopicViewController alloc] init];
    videoVC.title = @"视频";
    videoVC.topicType = JHTopicTypeVideo;
    [self addChildViewController:videoVC];
    
    JHTopicViewController *pictureVC = [[JHTopicViewController alloc] init];
    pictureVC.title = @"图片";
    pictureVC.topicType = JHTopicTypePicture;
    [self addChildViewController:pictureVC];
    
    JHTopicViewController *audioVC = [[JHTopicViewController alloc] init];
    audioVC.title = @"声音";
    audioVC.topicType = JHTopicTypeAudio;
    [self addChildViewController:audioVC];
    
    JHTopicViewController *wordVC = [[JHTopicViewController alloc] init];
    wordVC.title = @"段子";
    wordVC.topicType = JHTopicTypeWord;
    [self addChildViewController:wordVC];

}
/**
 *  设置头部
 */
- (void)setupHead {
    UIView *headView = [[UIView alloc] init];
    
    // 设置头部视图
    headView.frame = CGRectMake(0, JHHeadViewY, self.view.width, JHHeadViewH);
    headView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    
    // 设置头部视图按钮
//    NSArray *btnTitles = @[@"全部", @"视频", @"图片", @"段子", @"声音"];
    NSInteger btnCount = self.childViewControllers.count;
    CGFloat width = headView.width / btnCount;
    CGFloat height = headView.height;
    CGFloat y = 0;
    for (NSInteger i = 0; i < btnCount; i++) {
        // 添加按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat x = i * width;
        btn.frame = CGRectMake(x, y, width, height);
        [btn setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(headBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [headView addSubview:btn];
    }
    
    
    // 设置头部视图选中指示器
    UIView *selIndicator = [[UIView alloc] init];
    selIndicator.backgroundColor = [UIColor redColor];
//    selIndicator.width = width;
    selIndicator.height = 2;
    selIndicator.y = height - selIndicator.height;
    self.selIndicator = selIndicator;
    [headView addSubview:selIndicator];
    
    self.headView = headView;
    [self.view addSubview:headView];
}
/**
 *  头部按钮点击
 */
- (void)headBtnClick:(UIButton *)btn {
    // 避免重复点击按钮
    if (btn == self.currentSelHeadBtn) return;
    
    // 设置按钮选中状态  设置选中指示器位置(动画)
    // 此处代码交由 scrollViewDidEndScrollingAnimation 处理

    
//    // 确保一定能够触发滚动动画，设置初始offset为负数
//    CGPoint contentOffset = self.contentScrollView.contentOffset;
//    contentOffset.x = -self.view.width;
//    self.contentScrollView.contentOffset = contentOffset;
    // 滚动scrollView
    CGPoint offset = CGPointMake(self.view.width * btn.tag, 0);
    // 触发 scrollViewDidEndScrollingAnimation 方法
    [self.contentScrollView setContentOffset:offset animated:YES];
}

/**
 *  设置内容部分
 */
- (void)setupContent {
    // 设置scrollView
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    contentScrollView.delegate = self;
    contentScrollView.frame = self.view.bounds;
    contentScrollView.contentSize = CGSizeMake(self.view.width * self.childViewControllers.count, 0);
    contentScrollView.pagingEnabled = YES;
    
    // 为了刚进入画面能够触发滚动动画，设置初始offset为负数
    CGPoint contentOffset = contentScrollView.contentOffset;
    contentOffset.x = -self.view.width;
    contentScrollView.contentOffset = contentOffset;
    
    
    [self.view insertSubview:contentScrollView atIndex:0];
    self.contentScrollView = contentScrollView;
}

/**
 *  左上角导航栏按钮点击
 */
- (void)tagClick:(UIButton *)btn {
    JHRecommendTagViewController *vc = [[JHRecommendTagViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UIScrollViewDelegate
/**
 *  点击头部按钮时触发
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // 获取索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 1.滚动显示内容
    // 获取需要显示的vc
    UIViewController *tVC = self.childViewControllers[index];
    // 设置偏移
    tVC.view.frame = scrollView.bounds;
    tVC.view.x = scrollView.contentOffset.x;
    [scrollView addSubview:tVC.view];
    
    
    // 2.设置头部视图按钮和指示器状态
    // 获取当前需要处理的按钮
    UIButton *btn = self.headView.subviews[index];
    // 设置按钮选中状态
    self.currentSelHeadBtn.selected = NO;
    btn.selected = YES;
    self.currentSelHeadBtn = btn;
    
    
    // 设置选中指示器位置(动画)
    self.selIndicator.width = btn.titleLabel.width;
    [UIView animateWithDuration:0.2 animations:^{
        self.selIndicator.centerX = btn.centerX;
    }];
}
/**
 *  人为拖动时触发(相当于点击对应的头部视图按钮)
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
//    // 获取索引
//    NSInteger index = scrollView.contentOffset.x / scrollView.width;
//    // 获取当前需要处理的顶部视图按钮
//    UIButton *btn = self.headView.subviews[index];
//    // 点击对应的头部视图按钮
//    [self headBtnClick:btn];
}

@end
