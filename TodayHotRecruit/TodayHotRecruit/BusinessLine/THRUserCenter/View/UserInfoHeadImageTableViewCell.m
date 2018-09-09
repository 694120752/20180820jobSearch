//
//  UserInfoHeadImageTableViewCell.m
//  TodayHotRecruit
//
//  Created by 张精申 on 2018/9/9.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "UserInfoHeadImageTableViewCell.h"

@implementation UserInfoHeadImageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel* namelabel = [UILabel new];
        [self.contentView addSubview:namelabel];
        namelabel.sd_layout
        .leftSpaceToView(self.contentView, PXGet375Width(50))
        .rightSpaceToView(self.contentView, PXGet375Width(120 + 20))
        .centerYEqualToView(self.contentView)
        .heightRatioToView(self.contentView, 1);
        namelabel.backgroundColor = RANDOMCOLOR;
        
        /// 头像 120 * 120  右边20
        UIImageView* headerImage = [UIImageView new];
        headerImage.layer.cornerRadius = PXGet375Width(120) / 2;
        headerImage.clipsToBounds = YES;
        headerImage.backgroundColor = RANDOMCOLOR;
        [self.contentView addSubview:headerImage];
        headerImage.sd_layout
        .rightSpaceToView(self.contentView, PXGet375Width(20))
        .widthIs(PXGet375Width(120))
        .heightIs(PXGet375Width(120))
        .centerYEqualToView(self.contentView);
        
        
        
        
    }
    return self;
}

@end
