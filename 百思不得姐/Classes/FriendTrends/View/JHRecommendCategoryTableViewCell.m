//
//  JHRecommendCategoryTableViewCell.m
//  百思不得姐
//
//  Created by 李建華 on 16/3/26.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import "JHRecommendCategoryTableViewCell.h"

@interface JHRecommendCategoryTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *bottomLiner;
@property (weak, nonatomic) IBOutlet UILabel *customTextLabel;
@property (weak, nonatomic) IBOutlet UIView *leftLiner;

@end

@implementation JHRecommendCategoryTableViewCell

- (void)awakeFromNib {
    self.backgroundColor = JHRGBColore(244, 244, 244);
    self.leftLiner.backgroundColor = JHRGBColore(219, 21, 26);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // 设置文字颜色
    self.customTextLabel.textColor = selected ? self.leftLiner.backgroundColor : JHRGBColore(78, 78, 78);
    // 设置左侧红线是否可见
    self.leftLiner.hidden = !selected;
}


#pragma mark - SetMethods
- (void)setRecommendCaregory:(JHRecommendCategory *)recommendCaregory {
    _recommendCaregory = recommendCaregory;
    
    self.customTextLabel.text = recommendCaregory.name;
}
@end
