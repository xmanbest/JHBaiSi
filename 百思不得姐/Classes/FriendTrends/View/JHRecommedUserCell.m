//
//  JHRecommedUserCell.m
//  百思不得姐
//
//  Created by 李建華 on 16/3/28.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import "JHRecommedUserCell.h"
#import <UIImageView+WebCache.h>

@interface JHRecommedUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation JHRecommedUserCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setRecommendUser:(JHRecommendUser *)recommendUser {
    _recommendUser = recommendUser;
    
    self.screenNameLabel.text = recommendUser.screen_name;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:recommendUser.header]  placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    CGFloat fansNum = [recommendUser.fans_count doubleValue] / 10000;
    NSString *fansStr = fansNum >= 1 ? [NSString stringWithFormat:@"%0.1f万人关注", fansNum]  : [NSString stringWithFormat:@"%@人关注", recommendUser.fans_count];
    self.fansCountLabel.text = fansStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
