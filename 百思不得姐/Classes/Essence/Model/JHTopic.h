//
//  JHTopic.h
//  百思不得姐
//
//  Created by 李建華 on 16/4/2.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JHTopicUser.h"
#import "JHTopicImage.h"
#import "JHTopicGif.h"

// topic模型type属性的值
UIKIT_EXTERN NSString * const JHTopicAudioKey;
UIKIT_EXTERN NSString * const JHTopicVideoKey;
UIKIT_EXTERN NSString * const JHTopicGifKey;
UIKIT_EXTERN NSString * const JHTopicImageKey;
UIKIT_EXTERN NSString * const JHTopicWordKey;

@interface JHTopic : NSObject
#pragma mark - 通用
/**
 *  用户相关
 */
@property(nonatomic, strong)JHTopicUser *u;
/**
 *  段子内容
 */
@property(nonatomic, copy)NSString *text;
/**
 *  上传时间
 */
@property(nonatomic, copy)NSString *passtime;

/**
 *  底部控件按钮信息
 */
@property(nonatomic, copy)NSString *up;
@property(nonatomic, copy)NSString *down;
@property(nonatomic, copy)NSString *bookmark;
@property(nonatomic, copy)NSString *comment;
/**
 *  topic类型
 */
@property(nonatomic, copy)NSString *type;

#pragma mark - 图片
@property(nonatomic, strong)JHTopicImage *image;
@property(nonatomic, strong)JHTopicGif *gif;

#pragma mark - 辅助属性
/**
 * cell的高度
 */
@property(nonatomic, assign, readonly)CGFloat cellH;
/**
 *  cell图片视图的Frame
 */
@property(nonatomic, assign, readonly)CGRect picViewFrame;
/**
 *  图片是否超过高度的界限值
 */
@property(nonatomic, assign, getter=isTooLarge)BOOL tooLarge;
/**
 *  纪录已加载图片的进度
 */
@property(nonatomic, assign)CGFloat downloadProgress;
@end
