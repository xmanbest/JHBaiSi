//
//  JHCustomPlaceholdTextField.m
//  百思不得姐
//
//  Created by 李建華 on 16/3/31.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import "JHCustomPlaceholdTextField.h"
#import <objc/runtime.h>

static NSString * const customPlaceholderColoreKeyPath = @"_placeholderLabel.textColor";

@implementation JHCustomPlaceholdTextField

//+ (void)initialize {
//
//    unsigned int count;
//    Ivar *ivars = class_copyIvarList([UITextField class], &count);
//    
//    for (NSUInteger i = 0; i < count; i ++) {
////        Ivar ivar = *(ivars + 1);
//        Ivar ivar = ivars[i];
//        JHLog(@"%s", ivar_getName(ivar));
//    }
//}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setup];
}

/**
 *  自定义颜色
 */
- (void)setup {
    // 设置站位文字初始颜色为灰色
    [self setValue:[UIColor grayColor] forKeyPath:customPlaceholderColoreKeyPath];
    // 设置光标颜色为灰色
    self.tintColor = [self valueForKeyPath:customPlaceholderColoreKeyPath];
}

#pragma mark - overwrite
- (BOOL)becomeFirstResponder {
    // 获取焦点时，使占位文字颜色改为输入文字颜色
    [self setValue:self.textColor forKeyPath:customPlaceholderColoreKeyPath];
    
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
    // 失去焦点时，使展位文字颜色恢复为灰色
    [self setValue:[UIColor grayColor] forKeyPath:customPlaceholderColoreKeyPath];
    
    return [super resignFirstResponder];
}

@end
