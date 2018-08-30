//
//  JobTableViewCell.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/8/28.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "JobTableViewCell.h"

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
    jobImage.image = [UIImage imageNamed:@"placeHolder"];
    [self.contentView addSubview:jobImage];
    
    //地区
    UILabel* areaLabel = [[UILabel alloc]init];
    areaLabel.frame = CGRectMake(0, jobImage.mj_h + jobImage.mj_x, jobImage.mj_w + PXGet375Width(20)*2, PXGet375Width(55));
    areaLabel.backgroundColor = RANDOMCOLOR;
    areaLabel.font = [UIFont systemFontOfSize:PXGet375Width(25)];
    areaLabel.textColor = RGBACOLOR(177, 177, 177, 1);
    areaLabel.textAlignment = NSTextAlignmentCenter;
    areaLabel.text = @"南京市 - 江宁区";
    [self.contentView addSubview:areaLabel];
    
    //下面的线
    UIView* lineView = [UIView new];
    lineView.frame = CGRectMake(0, areaLabel.mj_y + areaLabel.mj_h, kScreenWidth, PXGet375Width(4));
    lineView.backgroundColor = RGBACOLOR(228, 228, 228, 1);
    [self.contentView addSubview:lineView];
    
    // 公司名
    UILabel* comLabel = [UILabel new];
    comLabel.frame = CGRectMake(jobImage.mj_w + PXGet375Width(40), PXGet375Width(20), kScreenWidth - (jobImage.mj_w + PXGet375Width(40) + PXGet375Width(180)), PXGet375Width(40));
    comLabel.text = @"Zjs6666666666666666666666666666666666666666666666666";
    comLabel.backgroundColor = RANDOMCOLOR;
    [self.contentView addSubview:comLabel];
    
    //生活补助的按钮  加上左右边距总计宽度 为PXGet375Width(180)
    UIButton* helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:helpButton];
    
    //工资
    UILabel* salaryLabel = [UILabel new];
    salaryLabel.frame = CGRectMake(comLabel.mj_x, comLabel.mj_h + comLabel.mj_y, comLabel.mj_w, PXGet375Width(50));
    salaryLabel.text = @"8000-10000";
    [self.contentView addSubview:salaryLabel];
    
    //taghang
    UIView* tagLine = [[UIView alloc]init];
    tagLine.frame = CGRectMake(comLabel.mj_x, salaryLabel.mj_y + salaryLabel.mj_h, comLabel.width + PXGet375Width(180), PXGet375Width(40));
    tagLine.backgroundColor = RANDOMCOLOR;
    [self.contentView addSubview:tagLine];
    
    //右下角注释
    UILabel* detaillabel= [UILabel new];
    // 这边后期做计算长度
    detaillabel.frame  = CGRectMake(kScreenWidth - PXGet375Width(100), areaLabel.mj_y, PXGet375Width(100), PXGet375Width(50));
    detaillabel.text = @"操作工";
    [self.contentView addSubview:detaillabel];
    

}

+(CGFloat)selfHeight{
    // + 120 + 55 + 5
    return PXGet375Width(20) + PXGet375Width(120) + PXGet375Width(55) + PXGet375Width(4);
}


@end
