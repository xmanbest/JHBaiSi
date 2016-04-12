//
//  JHPublishViewController.m
//  百思不得姐
//
//  Created by 李建華 on 16/4/12.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import "JHPublishViewController.h"
#import "JHVerticalButton.h"
#import <pop/POP.h>

static CGFloat const JHSpringFactor = 15;
static CGFloat const JHAnimateDelayFactor = 0.1;

@interface JHPublishViewController ()
@property(nonatomic, strong)NSArray *titleArray;
@end

@implementation JHPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册点击手势
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    // 取消所有控件的互动性
    self.view.userInteractionEnabled = NO;
    // 动画添加中部按钮
    [self setupBtns];
    // 动画添加标题ImageView
    [self setupTitleImageView];
}

/**
 *  动画添加中部按钮
 */
- (void)setupBtns {
    NSArray *imageArray = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    
    CGFloat btnW = 72;
    CGFloat btnH = btnW + 30;
    NSInteger maxCol = 3;
    CGFloat startX = 25;
    CGFloat marginX = (JHScreenW - 2 * startX - 3 * btnW) / (maxCol - 1);
    CGFloat startY = (JHScreenH - (self.titleArray.count / 3) * btnH) * 0.5;
    for (NSInteger i=0; i<self.titleArray.count; i++) {
        JHVerticalButton *btn = [[JHVerticalButton alloc] init];
        
        [btn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(publishBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i + 1;
        
        // frame计算
        NSInteger row = i / maxCol;
        NSInteger col = i % maxCol;
        CGFloat btnX = startX + (btnW + marginX) * col;
        CGFloat btnEndY = startY + btnH * row;
        
        // 设置动画
        POPSpringAnimation *btnAnimate = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        
        btnAnimate.fromValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnEndY-JHScreenH, btnW, btnH)];
        // 按钮终点frame
        btnAnimate.toValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnEndY, btnW, btnH)];
        // 设置延迟时间
        btnAnimate.beginTime = CACurrentMediaTime() + 0.1 * i;
        // 设置弹簧效果
        btnAnimate.springBounciness = JHSpringFactor;
        btnAnimate.springSpeed = JHSpringFactor;
        
        // 按钮添加动画
        [btn pop_addAnimation:btnAnimate forKey:nil];
        
        
        [self.view addSubview:btn];
    }

}

- (void)publishBtnClick:(UIButton *)publishBtn {
    switch (publishBtn.tag) {
        case 1:
            [self backWithCompletionBlock:^{
                // 此按钮在当前模态视图收起后执行的行为
                JHLog(@"点击了\"发视频\"按钮");
            }];
            break;
        case 2:
            [self backWithCompletionBlock:^{
                // 此按钮在当前模态视图收起后执行的行为
                JHLog(@"点击了\"发图片\"按钮");
            }];
            break;
        case 3:
            [self backWithCompletionBlock:^{
                // 此按钮在当前模态视图收起后执行的行为
                JHLog(@"点击了\"发段子\"按钮");
            }];
            break;
        case 4:
            [self backWithCompletionBlock:^{
                // 此按钮在当前模态视图收起后执行的行为
                JHLog(@"点击了\"发声音\"按钮");
            }];
            break;
        case 5:
            [self backWithCompletionBlock:^{
                // 此按钮在当前模态视图收起后执行的行为
                JHLog(@"点击了\"审帖\"按钮");
            }];
            break;
        case 6:
            [self backWithCompletionBlock:^{
                // 此按钮在当前模态视图收起后执行的行为
                JHLog(@"点击了\"离线下载\"按钮");
            }];
            break;
    }
}

/**
 *  动画添加标题ImageView
 */
- (void)setupTitleImageView {
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self.view addSubview:titleImageView];
    
    CGFloat titleCenterX = JHScreenW * 0.5;
    CGFloat titleEndCenterY = JHScreenH * 0.2;
    CGFloat titleStartCenterY = titleEndCenterY - JHScreenH;
    
    // 设置动画效果
    POPSpringAnimation *titleAnimate = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    
    titleAnimate.fromValue = [NSValue valueWithCGPoint:CGPointMake(titleCenterX, titleStartCenterY)];
    titleAnimate.toValue = [NSValue valueWithCGPoint:CGPointMake(titleCenterX, titleEndCenterY)];;
    // 设置延迟时间
    titleAnimate.beginTime = CACurrentMediaTime() + 0.1 * self.titleArray.count;
    // 设置弹簧效果
    titleAnimate.springBounciness = JHSpringFactor;
    titleAnimate.springSpeed = JHSpringFactor;
    // 设置结束回调block
    titleAnimate.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        // 恢复所有控件的互动性
        self.view.userInteractionEnabled = YES;
    };
    
    // 标题添加动画
    [titleImageView pop_addAnimation:titleAnimate forKey:nil];
}

/**
 *  收起本模态视图
 */
- (IBAction)back {
    [self backWithCompletionBlock:nil];
}

/**
 *  back的convenient方法
 */
- (void)backWithCompletionBlock:(void(^)())block{
    // 禁用所有控件的互动性
    self.view.userInteractionEnabled = NO;
    
    // 动画收起子控件（此处可以不用弹簧效果）
    NSInteger subviewBeginIndex = 2;
    for (NSInteger i=subviewBeginIndex; i<self.view.subviews.count; i++) {
        UIView *subview = self.view.subviews[i];
        POPBasicAnimation *subviewAnimate = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        
        subviewAnimate.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, subview.centerY + JHScreenH)];
        subviewAnimate.beginTime = CACurrentMediaTime() + JHAnimateDelayFactor * (i-subviewBeginIndex);
        // 设置动画速度曲线为漫进快出
        subviewAnimate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        // 为最后一个收起的子控件添加动画结束回调block
        if (i == self.view.subviews.count-1) {
            subviewAnimate.completionBlock = ^(POPAnimation *anim, BOOL finished) {
                [self dismissViewControllerAnimated:NO completion:nil];
                
                // 执行当前模态视图撤销后，自定义的block
                !block ? : block();
            };
            
        }
        
        [subview pop_addAnimation:subviewAnimate forKey:nil];
    }
}

#pragma mark - GetMethods
- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    }
    return _titleArray;
}

@end
