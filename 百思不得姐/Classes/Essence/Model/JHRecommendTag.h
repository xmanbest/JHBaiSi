//
//  JHRecommendTag.h
//  百思不得姐
//
//  Created by 李建華 on 16/3/29.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHRecommendTag : NSObject
/**
 *  图片url
 */
@property(nonatomic, copy)NSString *image_list;
/**
 *  标题
 */
@property(nonatomic, copy)NSString *theme_name;
/**
 *  订阅量
 */
@property(nonatomic, copy)NSString *sub_number;
@end
