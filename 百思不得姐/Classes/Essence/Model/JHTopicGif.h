//
//  JHTopicGif.h
//  百思不得姐
//
//  Created by 李建華 on 16/4/7.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHTopicGif : NSObject
@property(nonatomic, assign)CGFloat height;
@property(nonatomic, assign)CGFloat width;
@property(nonatomic, strong)NSDictionary *download_url;
/**
 *  显示图片url
 */
@property(nonatomic, strong)NSArray *images;
@end
