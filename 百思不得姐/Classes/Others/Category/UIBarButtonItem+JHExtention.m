//
//  UIBarButtonItem+JHExtention.m
//  百思不得姐
//
//  Created by 李建華 on 16/3/24.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import "UIBarButtonItem+JHExtention.h"

@implementation UIBarButtonItem (JHExtention)

+ (instancetype)itemWithImage:(NSString *)image highlightImage:(NSString *)highImage target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    btn.bounds = CGRectMake(0, 0, btn.currentBackgroundImage.size.width, btn.currentBackgroundImage.size.height);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:btn];
}
@end
