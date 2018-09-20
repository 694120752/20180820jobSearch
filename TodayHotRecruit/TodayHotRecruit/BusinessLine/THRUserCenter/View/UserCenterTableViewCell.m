//
//  UserCenterTableViewCell.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/8/29.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "UserCenterTableViewCell.h"
#import "UserDetail.h"

@implementation UserCenterTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.iconImage = [[UIImageView alloc]init];
        [self.contentView addSubview:self.iconImage];
        
        self.contentLabel = [[UILabel alloc]init];
        self.contentLabel.textColor = RGBACOLOR(121, 121, 121, 1);
        [self.contentView addSubview:self.contentLabel];
        
//        self.rightArr = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
//        [self.contentView addSubview:self.rightArr];
        
        self.rightLabel = [UILabel new];
        self.rightLabel.text = @"立即认证";
        self.rightLabel.textColor = RGBACOLOR(0, 133, 255, 1);
        self.rightLabel.font = font(PXGet375Width(30));
        [self.contentView addSubview:self.rightLabel];
        self.rightLabel.sd_layout
        .rightSpaceToView(self.contentView, PXGet375Width(30))
        .topEqualToView(self.contentView)
        .heightRatioToView(self.contentView, 1)
        .leftSpaceToView(self.contentLabel, 0);
        self.rightLabel.textAlignment = NSTextAlignmentRight;
        
        UIView* lineView = [UIView new];
        lineView.backgroundColor = RGBACOLOR(243, 243, 243, 1);
        [self addSubview:lineView];
        lineView.sd_layout
        .bottomSpaceToView(self, 0)
        .heightIs(1)
        .rightSpaceToView(self, 0)
        .widthIs(kScreenWidth);
    }
    return self;
}

-(void)setTitleIndex:(NSUInteger)titleIndex{
    
    BOOL isNeed = titleIndex < 3?YES:NO;
    
    switch (titleIndex) {
        case 1:
        {
            self.iconImage.image = [UIImage imageNamed:@"cer"];
            self.contentLabel.text = @"实名认证";
            self.contentLabel.font = font(PXGet375Width(35));
        }
            break;
        case 2:
        {
            self.iconImage.image = [UIImage imageNamed:@"HRcer"];
            self.contentLabel.text = @"公司HR认证";
            self.contentLabel.font = font(PXGet375Width(35));
        }
            break;
        case 4:
        {
            self.iconImage.image = [UIImage imageNamed:@"signUp"];
            self.contentLabel.text = @"我的报名";
            self.contentLabel.font = font(PXGet375Width(30));
        }
            break;
        case 5:
        {
            self.iconImage.image = [UIImage imageNamed:@"resume"];
            self.contentLabel.text = @"我的简历";
            self.contentLabel.font = font(PXGet375Width(30));
        }
            break;
        case 6:
        {
            self.iconImage.image = [UIImage imageNamed:@"set"];
            self.contentLabel.text = @"设置";
            self.contentLabel.font = font(PXGet375Width(30));
        }
            break;
        case 7:
        {
            self.iconImage.image = [UIImage imageNamed:@"about"];
            self.contentLabel.text = @"关于我们";
            self.contentLabel.font = font(PXGet375Width(30));
        }
            break;
            
        default:
            break;
    }
    
    self.rightLabel.hidden = !isNeed;
    
    self.iconImage.sd_layout
    .centerYEqualToView(self.contentView)
    .centerXIs(PXGet375Width(60))
    .heightIs(isNeed?PXGet375Width(50):PXGet375Width(35))
    .widthEqualToHeight();
    
    self.contentLabel.sd_layout
    .leftSpaceToView(self.iconImage, isNeed?PXGet375Width(15):PXGet375Width(40))
    .heightRatioToView(self.contentView, 1)
    .rightSpaceToView(self.contentView, PXGet375Width(220))
    .topSpaceToView(self.contentView, 0);
    
    NSDictionary* dic = [UserDetail getDetail];
    // 查询一下 重新定义标题  实名认证 0-否，1-是, 2-待审核，
    NSNumber* mark;
    if (titleIndex == 1) {
        // 实名认证
        mark  = EncodeNumberFromDic(dic, @"realFlag");
    }
    
    //Hr认证 0-否，1-是, 2-待审核，
    if (titleIndex == 2) {
        // 公司HR认证
        mark = EncodeNumberFromDic(dic, @"hrStatus");
    }
     
    if ([mark integerValue] == 0) {
        self.rightLabel.text = @"立即认证";
    }else if ([mark integerValue] == 1){
        self.rightLabel.text = @"已认证";
    }else if ([mark integerValue] == 2){
        self.rightLabel.text = @"待审核";
    }
    
}

+ (CGFloat)selfHeight{
    return PXGet375Width(100);
}

@end
