//
//  JobTableViewCell.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/8/28.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "JobTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+zFundation.h"

@implementation SubsidizeButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType{
    SubsidizeButton* button = [super buttonWithType:buttonType];
    button.priceLabel = [UILabel new];
    button.priceLabel.textAlignment = NSTextAlignmentCenter;
    button.priceLabel.textColor = RGBACOLOR(255, 79, 118, 1);
    button.priceLabel.font = font(PXGet375Width(18));
    [button addSubview:button.priceLabel];
    
    button.topLabel = [UILabel new];
    button.topLabel.textAlignment = NSTextAlignmentCenter;
    [button addSubview:button.topLabel];
    button.topLabel.text = @"生活补助";
    button.topLabel.backgroundColor = CommonBlue;
    button.topLabel.layer.cornerRadius = 8;
    button.topLabel.clipsToBounds = YES;
    button.topLabel.font = font(PXGet375Width(25));
    button.topLabel.textColor = [UIColor whiteColor];
    return button;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.topLabel.frame = CGRectMake(0, 0, self.width, PXGet375Width(50));
    self.priceLabel.frame = CGRectMake(0, PXGet375Width(55), self.width, self.height - PXGet375Width(55));
}


@end

@interface JobTableViewCell()
// 配图
@property (nonatomic, strong) UIImageView *jogImage;
@property (nonatomic, strong) UILabel *areaLabel;
// comLabel
@property (nonatomic, strong) UILabel *comLabel;
@property (nonatomic, strong) SubsidizeButton *helpButton;
@property (nonatomic, strong) UILabel *salaryLabel;
@property (nonatomic, strong) UILabel *detaillabel;
@property (nonatomic, strong) UIImageView *hasSign;
@property (nonatomic, strong) UIView *tagView;
@end

@implementation JobTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpJobDetail];
    }
    return self;
}

-(void)setUpJobDetail{
    //主图
    UIImageView* jobImage = [[UIImageView alloc]initWithFrame:CGRectMake(PXGet375Width(20), PXGet375Width(20), PXGet375Width(170), PXGet375Width(120))];
    //jobImage.image = [UIImage imageNamed:@"placeHolder"];
    _jogImage = jobImage;
    jobImage.backgroundColor = RANDOMCOLOR;
    jobImage.layer.cornerRadius = PXGet375Width(15);
    jobImage.clipsToBounds = YES;
    [self.contentView addSubview:jobImage];
    
    //地区
    UILabel* areaLabel = [[UILabel alloc]init];
    _areaLabel = areaLabel;
    areaLabel.frame = CGRectMake(0, jobImage.mj_h + jobImage.mj_x, jobImage.mj_w + PXGet375Width(20)*2, PXGet375Width(55));
    areaLabel.font = [UIFont systemFontOfSize:PXGet375Width(25)];
    areaLabel.textColor = RGBACOLOR(134, 134, 134, 1);
    areaLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:areaLabel];
    
    //下面的线
    UIView* lineView = [UIView new];
    lineView.frame = CGRectMake(0, areaLabel.mj_y + areaLabel.mj_h, kScreenWidth, 1);
    lineView.backgroundColor = RGBACOLOR(228, 228, 228, 1);
    [self.contentView addSubview:lineView];
    
    // 公司名
    UILabel* comLabel = [UILabel new];
    _comLabel = comLabel;
    comLabel.frame = CGRectMake(jobImage.mj_w + PXGet375Width(40), PXGet375Width(20), kScreenWidth - (jobImage.mj_w + PXGet375Width(40) + PXGet375Width(180)), PXGet375Width(40));
    comLabel.font = font(PXGet375Width(30));
    comLabel.textColor = RGBACOLOR(98, 98, 98, 1);
    [self.contentView addSubview:comLabel];
    
    //生活补助的按钮  加上左右边距总计宽度 为PXGet375Width(180)
    SubsidizeButton* helpButton = [SubsidizeButton buttonWithType:UIButtonTypeCustom];
    _helpButton = helpButton;
    helpButton.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:helpButton];
    helpButton.sd_layout
    .widthIs(PXGet375Width(150))
    .heightIs(PXGet375Width(80))
    .topSpaceToView(self.contentView, PXGet375Width(15))
    .rightSpaceToView(self.contentView, PXGet375Width(20));
    
    //工资
    UILabel* salaryLabel = [UILabel new];
    salaryLabel.frame = CGRectMake(comLabel.mj_x, comLabel.mj_h + comLabel.mj_y, comLabel.mj_w, PXGet375Width(50));
    _salaryLabel = salaryLabel;
    [self.contentView addSubview:salaryLabel];
    
    //tagLine
    UIView* tagLine = [[UIView alloc]init];
    _tagView = tagLine;
    tagLine.frame = CGRectMake(comLabel.mj_x, salaryLabel.mj_y + salaryLabel.mj_h, comLabel.width + PXGet375Width(180), PXGet375Width(40));
    [self.contentView addSubview:tagLine];
    
    //右下角注释
    UILabel* detaillabel= [UILabel new];
    _detaillabel = detaillabel;
    // 这边后期做计算长度
    detaillabel.frame  = CGRectMake(kScreenWidth - PXGet375Width(200), areaLabel.mj_y, PXGet375Width(180), PXGet375Width(50));
//    detaillabel.text = @"操作工";
    detaillabel.font = font(PXGet375Width(25));
    detaillabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:detaillabel];
    
    
    //地区重新布局
    areaLabel.sd_layout.rightSpaceToView(detaillabel, 5);
    areaLabel.sd_layout.leftSpaceToView(self.contentView, PXGet375Width(20));
    
    
    // 已报名戳子
    UIImageView* hasSign = [UIImageView new];
    hasSign.image = [UIImage imageNamed:@"hasSign"];
    hasSign.hidden = YES;
    _hasSign = hasSign;
    [self.contentView addSubview:hasSign];
    
    hasSign.sd_layout
    .rightSpaceToView(self.contentView, 0)
    .bottomSpaceToView(self.contentView, 0)
    .topSpaceToView(helpButton, 0)
    .widthEqualToHeight();
    
}

+(CGFloat)selfHeight{
    // + 120 + 55 + 5
    return PXGet375Width(20) + PXGet375Width(120) + PXGet375Width(55) + 1;
}

+ (CGFloat)cellHeightInMySign{
    return PXGet375Width(20) + PXGet375Width(120) + PXGet375Width(55) + PXGet375Width(20);
}


// 我的报名中 cell单独更新 多出右下角的一个戳子
- (void)mySignWithJob:(THRJob *)job{
    _job = job;
    _hasSign.hidden = NO;
    _detaillabel.hidden = YES;
    [_jogImage sd_setImageWithURL:[NSURL URLWithString:job.coverUrl] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    if (NotNilAndNull(job.company)) {
        _areaLabel.text = job.company.address;
//        _comLabel.text = ;
        
        NSString* orginStr = [[job.company.name stringByAppendingString:@"  "] stringByAppendingString:job.name];
        NSMutableAttributedString* comStr = [[NSMutableAttributedString alloc]initWithString:orginStr];
        NSRange jobNameRange = [orginStr rangeOfString:job.name];
        [comStr addAttribute:NSFontAttributeName value:font(10) range:jobNameRange];
        
        _comLabel.attributedText = comStr;
    }
    
    if (IsStrEmpty(job.subsidy)) {
        _helpButton.hidden = YES;
    }else{
        _helpButton.hidden = NO;
        _helpButton.priceLabel.text = [job.subsidy stringByAppendingString:@"元"];
    }
    
    if (!IsStrEmpty(job.salary)) {
        NSString* st = [job.salary stringByAppendingString:@"元/月"];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:st];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:[st rangeOfString:job.salary]];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:[st rangeOfString:@"元/月"]];
        
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:PXGet375Width(25)] range:[st rangeOfString:job.salary]];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:PXGet375Width(15)] range:[st rangeOfString:@"元/月"]];
        
        _salaryLabel.attributedText = str;
    }
    
    //_detaillabel.text = job.name;
    
    
    [_tagView z_removeAllSubviews];
    
    NSMutableArray<NSNumber*>* widthArr = [NSMutableArray array];
    [widthArr addObject:@(0)];
    
    if (!IsArrEmpty(job.tagList)) {
        for (NSUInteger i = 0  ;i< job.tagList.count ; i++) {
            NSString* tagStr = job.tagList[i];
            UILabel* taglabel = [UILabel new];
            CGSize titleSize;
            if (@available(iOS 8.2, *)) {
                titleSize = [tagStr sizeWithFont:[UIFont systemFontOfSize:PXGet375Width(18) weight:PXGet375Width(200)] limitedSize:CGSizeMake(MAXFLOAT, PXGet375Width(20)) lineBreakMode:NSLineBreakByWordWrapping];
                taglabel.font = [UIFont systemFontOfSize:PXGet375Width(18) weight:PXGet375Width(200)];
            } else {
                titleSize = [tagStr sizeWithFont:[UIFont systemFontOfSize:PXGet375Width(18)] limitedSize:CGSizeMake(MAXFLOAT, PXGet375Width(20)) lineBreakMode:NSLineBreakByWordWrapping];
                taglabel.font = font(PXGet375Width(18));
            }
            
            taglabel.frame = CGRectMake([widthArr[i] doubleValue], 0, titleSize.width + PXGet375Width(10)*2, PXGet375Width(35));
            taglabel.textColor = RGBACOLOR(200, 154, 223, 1);
            taglabel.layer.borderColor = RGBACOLOR(200, 154, 223, 1).CGColor;
            taglabel.layer.borderWidth = 1;
            taglabel.text = tagStr;
            taglabel.layer.cornerRadius = 3;
            taglabel.textAlignment = NSTextAlignmentCenter;
            
            [widthArr addObject:[NSNumber numberWithDouble:taglabel.mj_x + taglabel.mj_w + PXGet375Width(5)]];
            [_tagView addSubview:taglabel];
        }
    }
}

-(void)setJob:(THRJob *)job{
    _job = job;
     [_jogImage sd_setImageWithURL:[NSURL URLWithString:job.coverUrl] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    if (NotNilAndNull(job.company)) {
        _areaLabel.text = job.company.address;
        _comLabel.text = job.company.name;
    }
    
    if (IsStrEmpty(job.subsidy)) {
        _helpButton.hidden = YES;
    }else{
        _helpButton.hidden = NO;
        _helpButton.priceLabel.text = [job.subsidy stringByAppendingString:@"元"];
    }
    
    if (!IsStrEmpty(job.salary)) {
        NSString* st = [job.salary stringByAppendingString:@"元/月"];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:st];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:[st rangeOfString:job.salary]];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:[st rangeOfString:@"元/月"]];
        
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:PXGet375Width(25)] range:[st rangeOfString:job.salary]];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:PXGet375Width(15)] range:[st rangeOfString:@"元/月"]];

        _salaryLabel.attributedText = str;
    }
    
    _detaillabel.text = job.name;
    
    
    [_tagView z_removeAllSubviews];
    
    NSMutableArray<NSNumber*>* widthArr = [NSMutableArray array];
    [widthArr addObject:@(0)];
    
    if (!IsArrEmpty(job.tagList)) {
        for (NSUInteger i = 0  ;i< job.tagList.count ; i++) {
            NSString* tagStr = job.tagList[i];
            UILabel* taglabel = [UILabel new];
            CGSize titleSize;
            if (@available(iOS 8.2, *)) {
               titleSize = [tagStr sizeWithFont:[UIFont systemFontOfSize:PXGet375Width(18) weight:PXGet375Width(200)] limitedSize:CGSizeMake(MAXFLOAT, PXGet375Width(20)) lineBreakMode:NSLineBreakByWordWrapping];
                taglabel.font = [UIFont systemFontOfSize:PXGet375Width(18) weight:PXGet375Width(200)];
            } else {
                titleSize = [tagStr sizeWithFont:[UIFont systemFontOfSize:PXGet375Width(18)] limitedSize:CGSizeMake(MAXFLOAT, PXGet375Width(20)) lineBreakMode:NSLineBreakByWordWrapping];
                taglabel.font = font(PXGet375Width(18));
            }
            
            taglabel.frame = CGRectMake([widthArr[i] doubleValue], 0, titleSize.width + PXGet375Width(10)*2, PXGet375Width(35));
            taglabel.textColor = RGBACOLOR(200, 154, 223, 1);
            taglabel.layer.borderColor = RGBACOLOR(200, 154, 223, 1).CGColor;
            taglabel.layer.borderWidth = 1;
            taglabel.text = tagStr;
            taglabel.layer.cornerRadius = 3;
            taglabel.textAlignment = NSTextAlignmentCenter;
            
            [widthArr addObject:[NSNumber numberWithDouble:taglabel.mj_x + taglabel.mj_w + PXGet375Width(5)]];
            [_tagView addSubview:taglabel];
        }
    }
    
}

@end
