//
//  MessageCollectionViewCell.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/8/28.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "MessageCollectionViewCell.h"
#import "NSDate+Helper.h"

@implementation MessageCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupContent];
    }
    return self;
}

-(void)setupContent{
    UILabel* titleLabel = [[UILabel alloc]init];
    _titleContentLabel = titleLabel;
    _titleContentLabel.font = [UIFont systemFontOfSize:PXGet375Width(24)];
    _titleContentLabel.textColor = [UIColor darkTextColor];
    _titleContentLabel.frame = CGRectMake(PXGet375Width(200), 0, kScreenWidth - PXGet375Width(200) - PXGet375Width(200), PXGet375Width(50));
    [self.contentView addSubview:titleLabel];
    
    UILabel* timeLabel = [[UILabel alloc]init];
    _timeLabel = timeLabel;
    timeLabel.textColor = [UIColor lightTextColor];
    timeLabel.font = [UIFont systemFontOfSize:PXGet375Width(24)];
    [self.contentView addSubview:timeLabel];
    timeLabel.frame = CGRectMake(kScreenWidth - PXGet375Width(200), 0, PXGet375Width(200), PXGet375Width(50));
    timeLabel.text = [NSDate nowTimeStringWithFormart:@"MM月dd日 HH:mm"];
    
    UIButton* titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.contentMode = UIViewContentModeLeft;
    [titleButton setImage:[UIImage imageNamed:@"fire"] forState:UIControlStateNormal];
    titleButton.userInteractionEnabled = NO;
    [titleButton setTitle:@"天天领钱" forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont systemFontOfSize:PXGet375Width(25)];
    [titleButton setTitleColor:RGBACOLOR(200, 200, 200, 1) forState:UIControlStateNormal];
    [self.contentView addSubview:titleButton];
    titleButton.imageView.contentMode = UIViewContentModeCenter;
    titleButton.imageView.sd_layout
    .widthEqualToHeight()
    .leftSpaceToView(titleButton, 0);
    titleButton.titleLabel.sd_layout.leftSpaceToView(titleButton.imageView, 4);
    
    titleButton.sd_layout
    .leftSpaceToView(self.contentView, PXGet375Width(15))
    .rightSpaceToView(titleLabel, 0)
    .topSpaceToView(self.contentView, 0)
    .bottomSpaceToView(self.contentView, 0);
}
@end
