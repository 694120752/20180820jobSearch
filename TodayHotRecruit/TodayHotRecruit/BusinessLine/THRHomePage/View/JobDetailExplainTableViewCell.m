//
//  JobDetailExplainTableViewCell.m
//  TodayHotRecruit
//
//  Created by 张精申 on 2018/10/3.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "JobDetailExplainTableViewCell.h"
#import "UILabel+zFundation.h"
@interface JobDetailExplainTableViewCell()
/** titleLable*/
@property(nonatomic,strong)UILabel* detailTitle;

/** 第一个类目标题*/
@property(nonatomic,strong)UILabel* name1;
/** 第一个类目内容*/
@property(nonatomic,strong)UILabel* content1;

/** 第二个类目标题*/
@property(nonatomic,strong)UILabel* name2;
/** 第二个类目内容*/
@property(nonatomic,strong)UILabel* content2;
@end

@implementation JobDetailExplainTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    UIView *titleView = [UIView new];
    [self.contentView addSubview:titleView];
    titleView.sd_layout
    .topSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0)
    .heightIs(PXGet375Width(100));
    
    
    UIView *orginView = [UIView new];
    orginView.frame = CGRectMake(10, 20, 2, 30);
    orginView.backgroundColor = RGBACOLOR(247, 200, 124, 1);
    [titleView addSubview:orginView];
    
    UILabel* detailTitle = [UILabel new];
    _detailTitle = detailTitle;
    [titleView addSubview:detailTitle];
    detailTitle.frame = CGRectMake(orginView.right + 10, 20, kScreenWidth - orginView.right - 10, 30);
    
    
    // 四个label
    UILabel *name1 = [UILabel new];
    _name1 = name1;
    name1.layer.borderColor = RGBACOLOR(240, 240, 240, 0.8).CGColor;
    name1.layer.borderWidth = 1;
    name1.textAlignment = NSTextAlignmentCenter;
    name1.font = font(PXGet375Width(25));
    name1.textColor = RGBACOLOR(137, 137, 137, 1);
    [self.contentView addSubview:name1];
    
    UILabel *name2 = [UILabel new];
    _name2 = name2;
    name2.layer.borderColor = RGBACOLOR(240, 240, 240, 0.8).CGColor;
    name2.layer.borderWidth = 1;
    name2.textAlignment = NSTextAlignmentCenter;
    name2.font = font(PXGet375Width(25));
    name2.textColor = RGBACOLOR(137, 137, 137, 1);
    [self.contentView addSubview:name2];
    
    UILabel *content1 = [UILabel new];
    content1.numberOfLines = 0;
    content1.yf_contentInsets = UIEdgeInsetsMake(PXGet375Width(35), 10, PXGet375Width(35), 10);
    _content1 = content1;
    content1.layer.borderColor = RGBACOLOR(240, 240, 240, 0.8).CGColor;
    content1.layer.borderWidth = 1;
    content1.textColor = RGBACOLOR(78, 78, 78, 1);
    content1.font = font(PXGet375Width(25));
    [self.contentView addSubview:content1];
    
    UILabel *content2 = [UILabel new];
    content2.numberOfLines = 0;
    content2.yf_contentInsets = UIEdgeInsetsMake(PXGet375Width(35), 10, PXGet375Width(35), 10);
    _content2 = content2;
    content2.layer.borderColor = RGBACOLOR(240, 240, 240, 0.8).CGColor;
    content2.layer.borderWidth = 1;
    content2.textColor = RGBACOLOR(78, 78, 78, 1);
    content2.font = font(PXGet375Width(25));
    [self.contentView addSubview:content2];
    
    name1.sd_layout
    .widthIs(PXGet375Width(200))
    .leftSpaceToView(self.contentView, 0)
    .topSpaceToView(titleView, 0)
    .heightRatioToView(content1, 1);
    
    name2.sd_layout
    .widthIs(PXGet375Width(200))
    .leftSpaceToView(self.contentView, 0)
    .topSpaceToView(name1, 0)
    .heightRatioToView(content2, 1);
    
    content1.sd_layout
    .rightSpaceToView(self.contentView, 0)
    .leftSpaceToView(name1, 0)
    .topSpaceToView(titleView, 0);
    
    content2.sd_layout
    .rightSpaceToView(self.contentView, 0)
    .leftSpaceToView(name2, 0)
    .topSpaceToView(content1, 0);
    
    return self;
}

- (void)setContent:(NSArray *)contentArray andTitle:(NSString *)title{
    _detailTitle.text = title;
    
    NSDictionary *firstDic = [contentArray safeObjectAtIndex:0];
    _name1.text = EncodeStringFromDic(firstDic, @"name");
    _content1.text = EncodeStringFromDic(firstDic, @"dataValue");
    
    NSDictionary *lastData = [contentArray safeObjectAtIndex:1];
    _name2.text = EncodeStringFromDic(lastData, @"name");
    _content2.text = EncodeStringFromDic(lastData, @"dataValue");
    
    
    // 上下加35px  头尾共减 20pt
    
    CGSize contentSize1 = [_content1.text sizeWithFont:font(PXGet375Width(25)) limitedSize:CGSizeMake(kScreenWidth - PXGet375Width(200) - 20, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    CGSize contentSize2 = [_content2.text sizeWithFont:font(PXGet375Width(25)) limitedSize:CGSizeMake(kScreenWidth - PXGet375Width(200) - 20, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    _content1.sd_layout.heightIs(contentSize1.height + PXGet375Width(35) * 2);
    _content2.sd_layout.heightIs(contentSize2.height + PXGet375Width(35) * 2);
    
    
}

+ (CGFloat)cellHeightWithContent:(NSArray *)contentArray{
    
    NSDictionary *firstDic = [contentArray safeObjectAtIndex:0];
    NSDictionary *lastData = [contentArray safeObjectAtIndex:1];
    
    NSString *content1 = EncodeStringFromDic(firstDic, @"dataValue");
    NSString *content2 = EncodeStringFromDic(lastData, @"dataValue");
    
    CGSize contentSize1 = [content1 sizeWithFont:font(PXGet375Width(25)) limitedSize:CGSizeMake(kScreenWidth - PXGet375Width(200) - 20, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    CGSize contentSize2 = [content2 sizeWithFont:font(PXGet375Width(25)) limitedSize:CGSizeMake(kScreenWidth - PXGet375Width(200) - 20, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    return PXGet375Width(100) + contentSize1.height + PXGet375Width(35)*2 + contentSize2.height + PXGet375Width(35)*2;
}
@end
