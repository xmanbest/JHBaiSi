//
//  JHTopic.m
//  百思不得姐
//
//  Created by 李建華 on 16/4/2.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import "JHTopic.h"
#import "JHTopicPictureView.h"


// topic模型type属性的值
NSString * const JHTopicAudioKey = @"audio";
NSString * const JHTopicVideoKey = @"video";
NSString * const JHTopicGifKey = @"gif";
NSString * const JHTopicImageKey = @"image";
NSString * const JHTopicWordKey = @"text";

@interface JHTopic ()
{
    CGRect _picViewFrame;
}
@end

@implementation JHTopic
/**
 *  返回格式化的日期
 */
- (NSString *)passtime {
    // 设置时间格式
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 当前时间
    NSDate *nowDate = [NSDate date];
    // 创建时间
    NSDate *creatDate = [format dateFromString:_passtime];
    
    // 根据时间差显示不同信息
    if ([creatDate isThisYear]) { // 今年
        if ([creatDate isToday]) { // 今天
            NSDateComponents *compos = [creatDate deltaFromDate:nowDate];
            
            if (compos.hour >= 1) { // 其他
                return [NSString stringWithFormat:@"%zd小时前", compos.hour];
            }
            else if (compos.minute >= 1) { // 1小时内
                return [NSString stringWithFormat:@"%zd分钟前", compos.minute];
            }
            else { // 1分钟内
                return @"刚刚";
            }
            
        }
        else if ([creatDate isYesterday]) { // 昨天
            format.dateFormat = @"昨天 HH:mm:ss";
            return [format stringFromDate:creatDate];
        }
        else { // 其他
            format.dateFormat = @"MM-dd HH:mm:ss";
            return [format stringFromDate:creatDate];
        }
    }
    else { // 非今年
        return _passtime;
    }
}

/**
 *  返回cell高度
 */
- (CGFloat)cellH {
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width - 2*JHTopicMargin, MAXFLOAT);
    // 文本高度
    CGFloat textH = [self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
    
    // cell高度
    CGFloat cellH = JHIconH + JHBottomViewH + textH + 3*JHTopicMargin;
    
    // 图片topic相关
    if ([self.type isEqualToString:@"image"] || [self.type isEqualToString:@"gif"]) {
        // 此处计算图片视图Frame并保存，以便后续使用
        CGFloat pX = JHTopicMargin;
        CGFloat pY = JHIconH + textH + 3*JHTopicMargin;
        CGFloat pW = size.width; // 最大宽度
        CGFloat pH = [self.type isEqualToString:JHTopicImageKey] ?
        (self.image.height * pW) / self.image.width :
        (self.gif.height * pW) / self.gif.width;
        
        // 如果图片高度超过界限值，改为默认高度
        if (pH >= JHTopicPictureHLimit) {
            pH = JHTopicPictureHDefault;
            // 纪录是否超过了界限
            self.tooLarge = YES;
        } else {
            self.tooLarge = NO;
        }
        _picViewFrame = CGRectMake(pX, pY, pW, pH);
        
        // 图片视图高度
        cellH = cellH + pH + JHTopicMargin;
    }
    
    // cell的高度在setFrame方法中会减少10，所以此处提前增加10
    cellH += JHTopicMargin;
    return cellH;
}

@end
