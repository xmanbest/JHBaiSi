//
//  JHVerticalButton.m
//  百思不得姐
//
//  Created by 李建華 on 16/3/30.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import "JHVerticalButton.h"

@implementation JHVerticalButton

- (void)setup {
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
}

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

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, contentRect.size.width, contentRect.size.width, contentRect.size.height - contentRect.size.width);
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.width);
}

@end
