//
//  AdTableViewCell.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/8/30.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "AdTableViewCell.h"

@implementation AdTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //上面的线 4
        UIView* topLineView = [UIView new];
        topLineView.backgroundColor = RGBACOLOR(243, 243, 243, 1);
        [self.contentView addSubview:topLineView];
        
        //下面的线 5
        UIView* bottomLineView = [UIView new];
        bottomLineView.backgroundColor = RGBACOLOR(243, 243, 243, 1);
        [self.contentView addSubview:bottomLineView];
        
        topLineView.sd_layout
        .topSpaceToView(self.contentView, 4)
        .widthIs(kScreenWidth)
        .rightSpaceToView(self.contentView, 0)
        .heightIs(4);
        
        bottomLineView.sd_layout
        .bottomSpaceToView(self.contentView, 0)
        .widthIs(kScreenWidth)
        .rightSpaceToView(self.contentView, 0)
        .heightIs(5);
        
        //中间的主体图片
        UIImageView* adImage = [[UIImageView alloc]init];
        adImage.image = [UIImage imageNamed:@"placeHolder"];
        [self.contentView addSubview:adImage];
        
        adImage.sd_layout
        .topSpaceToView(topLineView, 0)
        .bottomSpaceToView(bottomLineView, 0)
        .rightSpaceToView(self.contentView, 0)
        .leftSpaceToView(self.contentView, 0);
    }
    return self;
}


+ (CGFloat)selfHeight{
    return PXGet375Width(220) + 9;
}
@end
