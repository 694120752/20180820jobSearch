//
//  BannerTableViewCell.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/8/27.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "BannerTableViewCell.h"
#import "SDCycleScrollView.h"

@interface BannerTableViewCell()<SDCycleScrollViewDelegate>
// broadcast
@property (nonatomic, strong) SDCycleScrollView *bannerView;
@end

@implementation BannerTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, PXGet375Width(250)) delegate:self placeholderImage:[UIImage imageNamed:@"placeHolder"]];
        
        [self.contentView addSubview:self.bannerView];
    }
    return self;
}

+(CGFloat)cellHeight{
    return PXGet375Width(250);
}


#pragma mark ---- 轮播回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectBannerIndex:)]) {
        [self.delegate selectBannerIndex:index];
    }
}

-(void)updateWithURL:(NSArray*)urlArray{
    // 更新轮播数据
    
}

@end
