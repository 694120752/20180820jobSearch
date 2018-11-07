//
//  UnderLineCardTableViewCell.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/21.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "UnderLineCardTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+zFundation.h"
#import "UILabel+zFundation.h"

@interface UnderLineCardTableViewCell()
/** 头图*/
@property(nonatomic,strong)UIImageView* mainImage;
/** 公司名*/
@property(nonatomic,strong)UILabel* nameLabel;
/** 地址*/
@property(nonatomic,strong)UILabel* addressLabel;
/** 路线*/
@property(nonatomic,strong)UILabel* routeLabel;
/** 联系电话*/
@property(nonatomic,strong)UILabel* contactLabel;
/** 联系人*/
@property(nonatomic,strong)UILabel* managerLable;
/** 手机*/
@property(nonatomic,strong)UILabel* phoneLabel;

/** naviButton*/
@property(nonatomic,strong)OutLineButton* naviButton;
@end

@implementation OutLineButton:UIButton

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(self.width - PXGet375Width(60) - PXGet375Width(40), self.height / 2 - PXGet375Width(60) / 2 - 7, PXGet375Width(60), PXGet375Width(60));
    self.titleLabel.frame = CGRectMake(self.imageView.mj_x, self.imageView.mj_h + self.imageView.mj_y, self.imageView.mj_w, PXGet375Width(25));
    self.titleLabel.font = font(10);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:RGBACOLOR(94, 157, 248, 1) forState:UIControlStateNormal];
}
@end

@implementation UnderLineCardTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self setUpCardView];
    
    return self;
}

- (void)setUpCardView{
    self.contentView.backgroundColor = RGBACOLOR(240, 240, 240, 1);

    // 头图
    UIImageView *mainImage = [[UIImageView alloc]init];
    _mainImage = mainImage;
    [self.contentView addSubview:mainImage];
    mainImage.sd_layout
    .topSpaceToView(self.contentView, PXGet375Width(30))
    .centerXEqualToView(self.contentView)
    .widthIs(PXGet375Width(666))
    .heightIs(PXGet375Width(270));
    
    
    // 公司名
    UILabel* nameLabel = [UILabel new];
    _nameLabel = nameLabel;
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.backgroundColor = RGBACOLOR(0, 0, 0, 0.7);
    nameLabel.font = font(PXGet375Width(30));
    [mainImage addSubview:nameLabel];
    nameLabel.sd_layout
    .bottomSpaceToView(mainImage, 0)
    .heightIs(PXGet375Width(60))
    .rightSpaceToView(mainImage, 0)
    .leftSpaceToView(mainImage, 0);
    
    // 地址 计算高度
    UILabel* addressLabel = [UILabel new];
    addressLabel.numberOfLines = 0;
    _addressLabel = addressLabel;
    addressLabel.backgroundColor = [UIColor whiteColor];
    addressLabel.textColor = RGBACOLOR(80, 80, 80, 1);
    addressLabel.font = font(16);
    addressLabel.yf_contentInsets = UIEdgeInsetsMake(PXGet375Width(30), PXGet375Width(20), PXGet375Width(10), PXGet375Width(20));
    [self.contentView addSubview:addressLabel];
    
    // 路线 计算高度
    UILabel* routeLabel = [UILabel new];
    _routeLabel = routeLabel;
    routeLabel.numberOfLines = 0;
    routeLabel.backgroundColor = [UIColor whiteColor];
    routeLabel.textColor = RGBACOLOR(80, 80, 80, 1);
    routeLabel.font = font(16);
    routeLabel.yf_contentInsets = UIEdgeInsetsMake(PXGet375Width(30), PXGet375Width(20), PXGet375Width(10), PXGet375Width(20));
    [self.contentView addSubview:routeLabel];
    
    // 导航
    OutLineButton* naviButton = [OutLineButton buttonWithType:UIButtonTypeCustom];
    _naviButton  = naviButton;
    naviButton.backgroundColor = [UIColor whiteColor];
    [naviButton setImage:[UIImage imageNamed:@"navi"] forState:UIControlStateNormal];
    [naviButton setTitle:@"导航" forState:UIControlStateNormal];
    [naviButton addTarget:self action:@selector(naviAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:naviButton];

    
    // 联系电话
    UILabel* contactLabel = [UILabel new];
    _contactLabel = contactLabel;
    contactLabel.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:contactLabel];
    contactLabel.textColor = RGBACOLOR(80, 80, 80, 1);
    contactLabel.font = font(16);
    contactLabel.yf_contentInsets = UIEdgeInsetsMake(PXGet375Width(30), PXGet375Width(20), PXGet375Width(10), PXGet375Width(20));
    _contactLabel.sd_layout
    .topSpaceToView(routeLabel, 0)
    .leftSpaceToView(self.contentView, (kScreenWidth - PXGet375Width(666))/2)
    .heightIs(PXGet375Width(85))
    .widthIs(PXGet375Width(470));
    
    OutLineButton* contentButton = [OutLineButton buttonWithType:UIButtonTypeCustom];
    contentButton.backgroundColor = [UIColor whiteColor];
    contentButton.tag = 1111;
    [contentButton setImage:[UIImage imageNamed:@"call"] forState:UIControlStateNormal];
    [contentButton setTitle:@"拨打" forState:UIControlStateNormal];
    [contentButton addTarget:self action:@selector(callAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:contentButton];
    contentButton.sd_layout
    .rightEqualToView(mainImage)
    .leftSpaceToView(contactLabel, 0)
    .topEqualToView(contactLabel)
    .heightRatioToView(contactLabel, 1);
    
    // 联系人
    UILabel* managerLable = [UILabel new];
    managerLable.backgroundColor = [UIColor whiteColor];
    _managerLable = managerLable;
    managerLable.textColor = RGBACOLOR(80, 80, 80, 1);
    managerLable.font = font(16);
    managerLable.yf_contentInsets = UIEdgeInsetsMake(PXGet375Width(30), PXGet375Width(20), PXGet375Width(10), PXGet375Width(20));
    [self.contentView addSubview:managerLable];
    managerLable.sd_layout
    .topSpaceToView(contactLabel, 0)
    .rightEqualToView(mainImage)
    .leftSpaceToView(self.contentView, (kScreenWidth - PXGet375Width(666))/2)
    .heightIs(PXGet375Width(80));
    
    // 手机
    UILabel *phoneLabel = [UILabel new];
    _phoneLabel = phoneLabel;
    phoneLabel.backgroundColor = [UIColor whiteColor];
    phoneLabel.textColor = RGBACOLOR(80, 80, 80, 1);
    phoneLabel.font = font(16);
    phoneLabel.yf_contentInsets = UIEdgeInsetsMake(PXGet375Width(30), PXGet375Width(20), PXGet375Width(10), PXGet375Width(20));
    [self.contentView addSubview:phoneLabel];
    phoneLabel.sd_layout
    .leftSpaceToView(self.contentView, (kScreenWidth - PXGet375Width(666))/2)
    .topSpaceToView(managerLable, 0)
    .heightIs(PXGet375Width(85))
    .widthIs(PXGet375Width(470));
//
    OutLineButton* phoneButton = [OutLineButton buttonWithType:UIButtonTypeCustom];
    phoneButton.backgroundColor = [UIColor whiteColor];
    phoneButton.tag = 2222;
    [phoneButton setImage:[UIImage imageNamed:@"call"] forState:UIControlStateNormal];
    [phoneButton setTitle:@"拨打" forState:UIControlStateNormal];
    [phoneButton addTarget:self action:@selector(callAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:phoneButton];
    phoneButton.sd_layout
    .rightEqualToView(mainImage)
    .leftSpaceToView(phoneLabel, 0)
    .topEqualToView(phoneLabel)
    .heightRatioToView(phoneLabel, 1);
    
    
    // 最下面再来80
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bottomView];
    
    bottomView.sd_layout
    .heightIs(PXGet375Width(80))
    .topSpaceToView(phoneLabel, 0)
    .rightEqualToView(mainImage)
    .leftEqualToView(mainImage);
    
    
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:mainImage.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.frame = mainImage.bounds;
    shapeLayer.path = bezierPath.CGPath;
    mainImage.layer.mask = shapeLayer;
    
    UIBezierPath *bezierPathB = [UIBezierPath bezierPathWithRoundedRect:bottomView.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *shapeLayerB = [[CAShapeLayer alloc] init];
    shapeLayerB.frame = bottomView.bounds;
    shapeLayerB.path = bezierPathB.CGPath;
    bottomView.layer.mask = shapeLayerB;
    
}


- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    NSString *coverRequestUrl = EncodeStringFromDic(dataDic, @"coverRequestUrl");
    [_mainImage sd_setImageWithURL:[NSURL URLWithString:coverRequestUrl] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    _nameLabel.text = EncodeStringFromDic(dataDic, @"name");
    
    NSString *addressStr = [@"地址：" stringByAppendingString:EncodeStringFromDic(dataDic, @"address")];
    CGSize titleSize = [addressStr sizeWithFont:font(17) limitedSize:CGSizeMake(PXGet375Width(666) - PXGet375Width(20)*2, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    NSMutableAttributedString* addressAttriStr = [[NSMutableAttributedString alloc]initWithString:addressStr];
    [addressAttriStr addAttribute:NSForegroundColorAttributeName value:RGBACOLOR(151, 151, 151, 1) range:NSMakeRange(0,3)];
    [addressAttriStr addAttribute:NSFontAttributeName value:font(15) range:NSMakeRange(0,3)];
    _addressLabel.attributedText = addressAttriStr;
    
    _addressLabel.sd_layout
    .topSpaceToView(_mainImage, PXGet375Width(0))
    .heightIs(titleSize.height + PXGet375Width(30) + PXGet375Width(10))
    .widthIs(PXGet375Width(666))
    .centerXEqualToView(self.contentView);
    
//    _routeLabel
    NSString* routeStr = [@"路线：" stringByAppendingString:EncodeStringFromDic(dataDic, @"route")];
    CGSize routeSize = [routeStr sizeWithFont:font(17) limitedSize:CGSizeMake(PXGet375Width(470), MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    NSMutableAttributedString *routeAttStr = [[NSMutableAttributedString alloc]initWithString:routeStr];
    [routeAttStr addAttribute:NSForegroundColorAttributeName value:RGBACOLOR(151, 151, 151, 1) range:NSMakeRange(0,3)];
    [routeAttStr addAttribute:NSFontAttributeName value:font(15) range:NSMakeRange(0,3)];
    _routeLabel.attributedText = routeAttStr;
    _routeLabel.sd_layout
    .leftEqualToView(_addressLabel)
    .topSpaceToView(_addressLabel, 0)
    .widthIs(PXGet375Width(470))
    .heightIs(routeSize.height + PXGet375Width(30) + PXGet375Width(10));
    
    _naviButton.sd_layout
    .rightEqualToView(_addressLabel)
    .leftSpaceToView(_routeLabel, 0)
    .topSpaceToView(_addressLabel, 0)
    .heightRatioToView(_routeLabel, 1);
    
    NSString* contentPhone = [@"联系电话：" stringByAppendingString:EncodeStringFromDic(dataDic, @"telphone")];
    NSMutableAttributedString *contentAttr = [[NSMutableAttributedString alloc]initWithString:contentPhone];
    [contentAttr addAttribute:NSForegroundColorAttributeName value:RGBACOLOR(151, 151, 151, 1) range:NSMakeRange(0,5)];
    [contentAttr addAttribute:NSFontAttributeName value:font(15) range:NSMakeRange(0,5)];
    _contactLabel.attributedText = contentAttr;
    
    NSString* contentPerson = [@"联系人：" stringByAppendingString:EncodeStringFromDic(dataDic, @"contacts")];
    NSMutableAttributedString *managerAttStr = [[NSMutableAttributedString alloc]initWithString:contentPerson];
    [managerAttStr addAttribute:NSForegroundColorAttributeName value:RGBACOLOR(151, 151, 151, 1) range:NSMakeRange(0,4)];
    [managerAttStr addAttribute:NSFontAttributeName value:font(15) range:NSMakeRange(0,4)];
    _managerLable.attributedText = managerAttStr;
    
    
    NSString* phoneStr = [@"手机：" stringByAppendingString:EncodeStringFromDic(dataDic, @"contactsPhone")];
    NSMutableAttributedString* phoneAttr = [[NSMutableAttributedString alloc]initWithString:phoneStr];
    [phoneAttr addAttribute:NSForegroundColorAttributeName value:RGBACOLOR(151, 151, 151, 1) range:NSMakeRange(0,3)];
    [phoneAttr addAttribute:NSFontAttributeName value:font(15) range:NSMakeRange(0,3)];
    _phoneLabel.attributedText = phoneAttr;
    
//    [self.contentView setNeedsLayout];
//    [self.contentView layoutIfNeeded];
    
    [_routeLabel setNeedsLayout];
    [_routeLabel layoutIfNeeded];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

+ (CGFloat)cellHeightWithDic:(NSDictionary *)dataDic{
    
    NSString *addressStr = [@"地址：" stringByAppendingString:EncodeStringFromDic(dataDic, @"address")];
    CGSize titleSize = [addressStr sizeWithFont:font(17) limitedSize:CGSizeMake(PXGet375Width(666) - PXGet375Width(20)*2, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    NSString* routeStr = [@"路线：" stringByAppendingString:EncodeStringFromDic(dataDic, @"route")];
    CGSize routeSize = [routeStr sizeWithFont:font(17) limitedSize:CGSizeMake(PXGet375Width(470), MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    return PXGet375Width(30) + PXGet375Width(270) + titleSize.height + PXGet375Width(30) + PXGet375Width(10) + PXGet375Width(30) + routeSize.height + PXGet375Width(10) + PXGet375Width(85) + PXGet375Width(80) + PXGet375Width(85) + PXGet375Width(80);
}

- (void)naviAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(naviWithDic:)]) {
        [self.delegate naviWithDic:self.dataDic];
    }
}

- (void)callAction:(UIButton *)button{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(callContentPhone:)]) {
    NSString* phoneStr;
    if (button.tag == 1111) {
        phoneStr = EncodeStringFromDic(self.dataDic, @"telphone");
    }else{
        phoneStr = EncodeStringFromDic(self.dataDic, @"contactsPhone");
    }
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phoneStr];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
        
//        [self.delegate callContentPhone:@""];
//    }
}

@end
