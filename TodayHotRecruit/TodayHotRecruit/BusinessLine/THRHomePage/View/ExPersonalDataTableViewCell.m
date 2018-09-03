//
//  ExPersonalDataTableViewCell.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/3.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "ExPersonalDataTableViewCell.h"

@interface ExPersonalDataTableViewCell ()
@property (nonatomic, strong) UILabel *bigLabel;

@property (nonatomic, strong) UILabel *leftLable;

@property (nonatomic, strong) UILabel *rightLabel;
@end

@implementation ExPersonalDataTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 左边的标题
        UILabel* smallLabel = [UILabel new];
        _leftLable = smallLabel;
        smallLabel.textColor = RGBACOLOR(150, 150, 150, 1);
        smallLabel.font = font(PXGet375Width(25));
        [self.contentView addSubview:smallLabel];
        
        UIView* rightBgView = [UIView new];
        rightBgView.backgroundColor = RGBACOLOR(246, 246, 246, 1);
        [self.contentView addSubview:rightBgView];
        rightBgView.sd_layout
        .topSpaceToView(self.contentView, PXGet375Width(20))
        .bottomSpaceToView(self.contentView, PXGet375Width(20))
        .leftSpaceToView(smallLabel, PXGet375Width(50))
        .widthIs(PXGet375Width(520));
        
        // 右边的内容
        UILabel* rightLabel = [UILabel new];
        _rightLabel = rightLabel;
        rightLabel.font = font(PXGet375Width(28));
        rightLabel.textColor = RGBACOLOR(150, 150, 150, 1);
        rightLabel.numberOfLines = 0;
        [rightBgView addSubview:rightLabel];
        
        smallLabel.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, PXGet375Width(50))
        .widthIs(PXGet375Width(100))
        .heightRatioToView(self.contentView, 1);
        
        rightLabel.sd_layout
        .topSpaceToView(rightBgView, PXGet375Width(25))
        .leftSpaceToView(rightBgView, PXGet375Width(20))
        .widthIs(PXGet375Width(480))
        .bottomSpaceToView(rightBgView, PXGet375Width(25));
        
    }
    return self;
}

-(void)setLeftStr:(NSString *)leftStr{
    _leftStr = leftStr;
    _leftLable.text = leftStr;
}

-(void)setContentStr:(NSString *)contentStr{
    _contentStr = contentStr;
    _rightLabel.text = contentStr;
}

+(CGFloat)selfHeightWithStr:(NSString*)str{
    CGSize titleSize = [str sizeWithFont:font(PXGet375Width(28)) limitedSize:CGSizeMake(PXGet375Width(480), MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    return titleSize.height + PXGet375Width(50) + PXGet375Width(20) + PXGet375Width(20);
}
@end
