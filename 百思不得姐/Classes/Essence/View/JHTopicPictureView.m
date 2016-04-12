//
//  JHTopicPictureView.m
//  百思不得姐
//
//  Created by 李建華 on 16/4/7.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import "JHTopicPictureView.h"
#import <UIImageView+WebCache.h>
#import "JHProgressView.h"
#import "JHShowBigPicViewController.h"

@interface JHTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *gifIdentifier;
@property (weak, nonatomic) IBOutlet UIButton *enlargeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet JHProgressView *progressView;
@end

@implementation JHTopicPictureView
/**
 * 实例化
 */
+ (instancetype)pictureView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JHTopicPictureView class]) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    // 取消autoresizeing对Frame的干扰
    self.autoresizingMask = UIViewAutoresizingNone;
    // 设置图片点击手势识别
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(picImageViewClick)]];
}

- (void)setTopic:(JHTopic *)topic {
    _topic = topic;
    
    // 网络加载显示图片
    NSURL *picUrl = nil;
    if ([topic.type isEqualToString:JHTopicImageKey]) { // image
        picUrl = [topic.image.big firstObject];
    } else if ([topic.type isEqualToString:JHTopicGifKey]) { // gif
        picUrl = [topic.gif.images firstObject];
    }
    
    // (1)每次复用cell确保进度条初始显示为实时下载进度，需要提取数据模型保存的数据
    [self.progressView setProgress:topic.downloadProgress animated:NO];
    
    [self.picImageView sd_setImageWithURL:picUrl placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        // 环形进度条显示
        self.progressView.hidden = NO;
        // (2)每次复用cell确保进度条初始显示为实时下载进度，需要实时把下载进度保存到数据模型中
        topic.downloadProgress = 1.0 * receivedSize / expectedSize;
        [self.progressView setProgress:topic.downloadProgress animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 环形进度条隐藏
        self.progressView.hidden = YES;
        
        // 不是大图不需要下面的操作
        if (!topic.isTooLarge) return;
        // 获取大图显示顶部部分
        UIImage *topPartImage = [self getTopPartFromLargeImage:image inPicSize:topic.picViewFrame.size];
        // 设置图片视图显示顶部部分图片
        self.picImageView.image = topPartImage;
    }];
    
    // 此处设置是否隐藏内部空间
    self.gifIdentifier.hidden = ![topic.type isEqualToString:JHTopicGifKey];
    // 不是大图时，隐藏点击扩大按钮
    self.enlargeBtn.hidden = !topic.isTooLarge;
}

/**
 *  返回需要折叠的大图的顶部部分
 */
- (UIImage *)getTopPartFromLargeImage:(UIImage *)largeImage inPicSize:(CGSize)picSize{
    // 开启绘图上下文，并确定画布尺寸
    UIGraphicsBeginImageContextWithOptions(picSize, YES, 0.0);
    
    // 上下文画布上需要绘入的图形尺寸（高度大与画布高度，宽度等于画布宽度）
    CGFloat drawW = picSize.width;
    CGFloat drawH = drawW * largeImage.size.height / largeImage.size.width;
    [largeImage drawInRect:CGRectMake(0, 0, drawW, drawH)];
    
    // 从绘图上下文中取得图片
    UIImage *topPartImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭绘图上下文
    UIGraphicsEndImageContext();
    
    return topPartImage;
}

/**
 *  图片点击手势响应方法
 */
- (void)picImageViewClick {
    // 模态视图显示放大图片
    JHShowBigPicViewController *vc = [[JHShowBigPicViewController alloc] init];
    vc.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}
@end
