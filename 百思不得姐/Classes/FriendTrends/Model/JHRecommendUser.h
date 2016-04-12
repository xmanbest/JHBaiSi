//
//  JHRecommendUser.h
//  百思不得姐
//
//  Created by 李建華 on 16/3/28.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHRecommendUser : NSObject
/*
{
    "list": [{
        "uid": "8918517",
        "screen_name": "泡面来了",
        "introduction": "",
        "fans_count": "9021",
        "tiezi_count": 17,
        "header": "http:%/%/img.spriteapp.cn%/profile%/large%/2014%/10%/22%/544712a631641_mini.jpg",
        "gender": 2,
        "is_follow": 0
    }],
    "total": 18,
    "next_page": 2,
    "total_page": 1
}
 */
@property(nonatomic, copy)NSString *screen_name;
@property(nonatomic, copy)NSString *header;
@property(nonatomic, copy)NSString *fans_count;
@end
