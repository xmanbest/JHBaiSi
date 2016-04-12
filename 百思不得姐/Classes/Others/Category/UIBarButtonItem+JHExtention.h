//
//  UIBarButtonItem+JHExtention.h
//  百思不得姐
//
//  Created by 李建華 on 16/3/24.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (JHExtention)
+ (instancetype)itemWithImage:(NSString *)image highlightImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
