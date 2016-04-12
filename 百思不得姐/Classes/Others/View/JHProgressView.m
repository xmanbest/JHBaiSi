//
//  JHProgressView.m
//  百思不得姐
//
//  Created by 李建華 on 16/4/11.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import "JHProgressView.h"

@implementation JHProgressView
- (void)awakeFromNib {
    // 设置下载进度条字体颜色
    self.progressLabel.textColor = [UIColor whiteColor];
    // 设置进度条头为圆形
    self.roundedCorners = 5;
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    [super setProgress:progress animated:animated];
    
    // 改变环形进度条label显示
    self.progressLabel.text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
}
@end
