//
//  JHRecommendCategory.h
//  百思不得姐
//
//  Created by 李建華 on 16/3/26.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHRecommendCategory : NSObject
@property(nonatomic, copy)NSString *ID;
@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *count;

/**
 *  本分类对应的右侧tableView数据
 */
@property(nonatomic, strong)NSMutableArray *users;
/**
 *  当前分类包涵的总条目
 */
@property(nonatomic, assign)NSInteger total;
/**
 *  当前分类显示的当前页
 */
@property(nonatomic, assign)NSInteger currentPage;
@end
