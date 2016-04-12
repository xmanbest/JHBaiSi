//
//  JHRecommendCategory.m
//  百思不得姐
//
//  Created by 李建華 on 16/3/26.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import "JHRecommendCategory.h"
#import <MJExtension.h>

@implementation JHRecommendCategory
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

- (NSMutableArray *)users {
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}
@end
