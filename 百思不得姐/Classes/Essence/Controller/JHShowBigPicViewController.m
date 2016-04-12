//
//  JHShowBigPicViewController.m
//  百思不得姐
//
//  Created by 李建華 on 16/4/11.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import "JHShowBigPicViewController.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import "JHProgressView.h"

@interface JHShowBigPicViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
// 在scrollView上的imageView视图
@property (weak, nonatomic) UIImageView *bigImageView;
// 环形进度条
@property (weak, nonatomic) IBOutlet JHProgressView *progressView;
@end

@implementation JHShowBigPicViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.imageScrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    
    // 设置图片
    [self setupBigImageView];
}

- (UIImageView *)bigImageView {
    if (!_bigImageView) {
        UIImageView *bigImageView = [[UIImageView alloc] init];
        // 在scrollView上添加imageView视图
        [self.imageScrollView addSubview:bigImageView];
        _bigImageView = bigImageView;
    }
    return _bigImageView;
}

/**
 *  设置大图的url以及Frame
 */
- (void)setupBigImageView {
    JHTopic *topic = self.topic;
    BOOL isImage = [topic.type isEqualToString:JHTopicImageKey];
    
    // 大图片的url
    NSURL *bigUrl = isImage ? [topic.image.big firstObject] : [topic.gif.images firstObject];
    
    // (1)确保环形进度条实时显示下载进度，刚进入画面需要从数据模型中提取已下载的进度
    [self.progressView setProgress:topic.downloadProgress animated:NO];
    
    // 下载图片并显示环形进度条(对同一份url，SDImage会共享下载进度)
    [self.bigImageView sd_setImageWithURL:bigUrl placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        [self.progressView setProgress:(1.0 * receivedSize / expectedSize) animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    
    // 设置imageView的Frame
    CGFloat bigW = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = isImage ? topic.image.height : topic.gif.height;
    CGFloat width = isImage ? topic.image.width : topic.gif.width;
    CGFloat bigH = bigW * height / width;
    
    self.bigImageView.size = CGSizeMake(bigW, bigH);
    if (bigH > [UIScreen mainScreen].bounds.size.height) { // 当bigH超过屏幕高度
        // 扩张scrollView的contentSize
        self.imageScrollView.contentSize = CGSizeMake(0, bigH);
    } else { // bigH不超过屏幕高度
        // 显示在屏幕中央
        self.bigImageView.centerY = [UIScreen mainScreen].bounds.size.height * 0.5;
    }
}

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  保存按钮点击
 */
- (IBAction)saveBtnClick:(id)sender {
    // 保存图片到相册
    UIImageWriteToSavedPhotosAlbum(self.bigImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
/**
 *  保存图片到相册回调方法
 */
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (!image) {
        [SVProgressHUD showErrorWithStatus:@"图片尚未下载完全！"];
        return;
    }
    
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败！"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
    }
}
@end
