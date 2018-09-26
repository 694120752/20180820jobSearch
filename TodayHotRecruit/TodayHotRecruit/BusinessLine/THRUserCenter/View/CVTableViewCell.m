//
//  CVTableViewCell.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/26.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "CVTableViewCell.h"

@interface CVTableViewCell()
/** 第一行工作经历*/
@property (nonatomic, strong) UILabel *firstTitleLabel;
@end

@implementation CVTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    // 上方的空白
    UIView* lineView = [UIView new];
    lineView.backgroundColor = RGBACOLOR(240, 240, 240, 1);
    [self.contentView addSubview:lineView];
    
    lineView.sd_layout
    .topSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0)
    .heightIs(PXGet375Width(15));
    
    
    // 五行内容
    
    // 第一行工作经历
    UIView *titleView = [UIView new];
    titleView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:titleView];
    titleView.sd_layout
    .topSpaceToView(lineView, 0)
    .rightSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0)
    .heightIs(PXGet375Width(90));
    
    UIView *floatView = [UIView new];
    [titleView addSubview:floatView];
    floatView.backgroundColor = CommonBlue;
    floatView.sd_layout
    .leftSpaceToView(titleView, PXGet375Width(30))
    .heightRatioToView(titleView, 0.7)
    .centerYEqualToView(self.contentView)
    .widthIs(2);
    
    UILabel* firstTitleLabel = [UILabel new];
    _firstTitleLabel = firstTitleLabel;
    [titleView addSubview:firstTitleLabel];
    
    firstTitleLabel.sd_layout
    .leftSpaceToView(floatView, PXGet375Width(25))
    .rightSpaceToView(titleView, 0)
    .topSpaceToView(titleView, 0)
    .bottomSpaceToView(titleView, 0);
    
    // 标题下面的间隔
    UIView* firstLine = [UIView new];
    firstLine.backgroundColor = RGBACOLOR(240, 240, 240, 1);
    [self.contentView addSubview:firstLine];
    firstLine.sd_layout
    .topSpaceToView(titleView, 0)
    .rightSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0)
    .heightIs(1);
    
    // 工厂名称
    UIView* comNameView = [UIView new];
    [self.contentView addSubview:comNameView];
    comNameView.sd_layout
    .topSpaceToView(firstLine, 0)
    .rightSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0)
    .heightIs(PXGet375Width(90));
    
    UILabel* cml = [UILabel new];
    cml.text = @"工厂名称";
    [comNameView addSubview:cml];
    cml.sd_layout
    .leftSpaceToView(comNameView, Get375Width(30) + Get375Width(25) + 2)
    .topSpaceToView(comNameView, 0)
    .bottomSpaceToView(comNameView, 0)
    .widthIs(Get375Width(100));
    
    UIImageView* rightArrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rightarrow"]];
    [self.contentView addSubview:rightArrow];
    
    return self;
}


-(void)setDic:(NSDictionary *)dic{
    _dic = dic;
}


+ (CGFloat)cellHeight{
    return PXGet375Width(15) + PXGet375Width(90) + 1 + PXGet375Width(90);
}
@end
