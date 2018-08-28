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
    UIButton* titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:titleButton];
    
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
}
@end
