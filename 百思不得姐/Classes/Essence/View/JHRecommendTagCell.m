//
//  JHRecommendTagCell.m
//  百思不得姐
//
//  Created by 李建華 on 16/3/29.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import "JHRecommendTagCell.h"
#import <UIImageView+WebCache.h>

@interface JHRecommendTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;

@end

@implementation JHRecommendTagCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setFrame:(CGRect)frame {
    
    // 固定cell的frame
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    
    [super setFrame:frame];
}

- (void)setRecommendTag:(JHRecommendTag *)recommendTag {
    _recommendTag = recommendTag;
    
    self.nameLabel.text = recommendTag.theme_name;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    CGFloat subNum = [recommendTag.sub_number doubleValue] / 10000;
    NSString *subStr = subNum >= 1 ? [NSString stringWithFormat:@"%0.1f万人订阅", subNum]  : [NSString stringWithFormat:@"%@人订阅", recommendTag.sub_number];
    self.subLabel.text = subStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
