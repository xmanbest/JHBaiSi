//
//  JHTopicPictureView.h
//  百思不得姐
//
//  Created by 李建華 on 16/4/7.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHTopic.h"

@interface JHTopicPictureView : UIView
@property(nonatomic, strong)JHTopic *topic;

+ (instancetype)pictureView;
@end
