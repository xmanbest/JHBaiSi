//
//  JHTabBar.m
//  百思不得姐
//
//  Created by 李建華 on 16/3/24.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import "JHTabBar.h"
#import "JHPublishViewController.h"

@interface JHTabBar ()
@property(nonatomic, weak)UIButton *publishButton;
@end

@implementation JHTabBar
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 设置tabBar的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        
        // 添加自定义“加号”按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        publishButton.bounds = CGRectMake(0, 0, publishButton.currentBackgroundImage.size.width, publishButton.currentBackgroundImage.size.height);
        [publishButton addTarget:self action:@selector(publishBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    // 加号按钮放到中间
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    // 调整其他tabBarButton位置
    CGFloat btnY = 0;
    CGFloat btnW = width * 0.2;
    CGFloat btnH = height;
    
    NSUInteger index = 0;
    for (UIView *button in self.subviews) {
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) continue;
        CGFloat btnX = btnW * (index > 1 ? index + 1 : index);
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        index ++;
    }
}

/**
 *  加号按钮点击
 */
- (void)publishBtnClick {
    JHPublishViewController *publishVC = [[JHPublishViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publishVC animated:NO completion:nil];
}
@end
