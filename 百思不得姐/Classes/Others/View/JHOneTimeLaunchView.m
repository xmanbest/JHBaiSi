//
//  JHOneTimeLaunchView.m
//  百思不得姐
//
//  Created by 李建華 on 16/3/31.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import "JHOneTimeLaunchView.h"

static NSString * const JHBundleShortVersionString = @"CFBundleShortVersionString";

@implementation JHOneTimeLaunchView

/**
 *  创建视图
 */
+ (instancetype)oneTimeLaunchView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JHOneTimeLaunchView class]) owner:nil options:nil] lastObject];
}

/**
 * 当前版本为第一次打开时，显示提示视图
 */
+ (void)show {
    // 获取当前版本
    NSString *currentVersion = [[NSBundle mainBundle] infoDictionary][JHBundleShortVersionString];
    // 获取纪录的版本
    NSString *recordedVersion = [[NSUserDefaults standardUserDefaults] objectForKey:JHBundleShortVersionString];
    
    // 当前版本为第一次打开时，显示提示视图
    if (![currentVersion isEqualToString:recordedVersion]) {
        
        // 创建时图并添加到主窗口上
        JHOneTimeLaunchView *oneTimeView = [self oneTimeLaunchView];
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        oneTimeView.frame = window.frame;
        [window addSubview:oneTimeView];
        
        // 把当前版本保存为纪录版本
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:JHBundleShortVersionString];
    }
}

- (IBAction)iKnowBtnClick:(id)sender {
    [self removeFromSuperview];
}


@end
