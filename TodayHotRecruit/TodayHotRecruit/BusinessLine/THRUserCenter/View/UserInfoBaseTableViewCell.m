//
//  UserInfoBaseTableViewCell.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/18.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "UserInfoBaseTableViewCell.h"
#import "UserDetail.h"

@interface UserInfoBaseTableViewCell()
// 左边的标题描述
@property (nonatomic, strong) UILabel *leftTitle;

// 右边的值
@property (nonatomic, strong) UILabel *rightTitle;
@end

@implementation UserInfoBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        self.leftTitle = [UILabel new];
        [self.contentView addSubview:self.leftTitle];
        
        self.rightTitle = [UILabel new];
        self.rightTitle.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.rightTitle];
        
        self.leftTitle.textColor = [UIColor darkTextColor];
        self.rightTitle.textColor = [UIColor lightTextColor];

        
        self.leftTitle.font = font(PXGet375Width(28));
        self.rightTitle.font = font(PXGet375Width(28));
        
        _leftTitle.sd_layout
        .leftSpaceToView(self.contentView, PXGet375Width(60))
        .widthIs(PXGet375Width(140))
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0);
        
        _rightTitle.sd_layout
        .rightSpaceToView(self.contentView, 20)
        .leftSpaceToView(_leftTitle, 0)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0);
        
        //rightArrow
        
//        UIImageView* arrowImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rightArrow"]];
//        [self.contentView addSubview:arrowImage];
//        arrowImage.sd_layout
//        .rightSpaceToView(self.contentView, PXGet375Width(20))
//        .leftSpaceToView(_rightTitle, PXGet375Width(20))
//        .centerYEqualToView(self.contentView)
//        .heightIs(PXGet375Width(40));
        
        
    }
    return self;
}

- (void)setLabelCase:(NSString *)labelCase{

    if ([labelCase isEqualToString:@"nickName"]) {
        self.leftTitle.text = @"昵称";
        self.rightTitle.text = [[UserDetail getDetail] objectForKey:labelCase];
    }

    //sex
    if ([labelCase isEqualToString:@"sex"]) {
        self.leftTitle.text = @"性别";
        self.rightTitle.text = [EncodeNumberFromDic([UserDetail getDetail], labelCase)  isEqual: @(2)]?@"女":@"男";
    }

    //phone
    if ([labelCase isEqualToString:@"userName"]) {
        self.leftTitle.text = @"手机号码";
        self.rightTitle.text = [[UserDetail getDetail] objectForKey:labelCase];
    }

    //birthday
    if ([labelCase isEqualToString:@"birthday"]) {
        self.leftTitle.text = @"我的生日";
        self.rightTitle.text = [[UserDetail getDetail] objectForKey:labelCase];
    }

    //cityName
    if ([labelCase isEqualToString:@"cityName"]) {
        self.leftTitle.text = @"所在城市";
        self.rightTitle.text = [[UserDetail getDetail] objectForKey:labelCase];
    }

    //birthCityName
    if ([labelCase isEqualToString:@"birthCityName"]) {
        self.leftTitle.text = @"我的家乡";
        self.rightTitle.text = [[UserDetail getDetail] objectForKey:labelCase];
    }

    //education
    if ([labelCase isEqualToString:@"education"]) {
        self.leftTitle.text = @"学历";
        self.rightTitle.text = [[UserDetail getDetail] objectForKey:labelCase];
    }

}

@end
