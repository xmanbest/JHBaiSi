//
//  JHTopicViewController.h
//  百思不得姐
//
//  Created by 李建華 on 16/4/6.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JHTopicType) {
    JHTopicTypeAll = 1,
    JHTopicTypePicture = 10,
    JHTopicTypeWord = 29,
    JHTopicTypeAudio = 31,
    JHTopicTypeVideo = 41
};

@interface JHTopicViewController : UITableViewController
@property(nonatomic, assign)JHTopicType topicType;
@end
