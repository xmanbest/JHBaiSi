//
//  JHUser.h
//  百思不得姐
//
//  Created by 李建華 on 16/4/2.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHTopicUser : NSObject
/**
 *  头像图片url
 */
@property(nonatomic, strong)NSArray *header;
@property(nonatomic, assign)BOOL is_v;
@property(nonatomic, assign)BOOL is_vip;
/**
 *  用户名字
 */
@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *uid;
@end
