//
//  JobDetailTitleViewTableViewCell.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/30.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "JobDetailTitleViewTableViewCell.h"
#import "FSSegmentTitleView.h"

@interface JobDetailTitleViewTableViewCell()<FSSegmentTitleViewDelegate>

@end

@implementation JobDetailTitleViewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    FSSegmentTitleView * titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 1, kScreenWidth, PXGet375Width(67)) titles:@[@"薪资情况",@"岗位说明",@"录用条件",@"食宿介绍",@"其他说明"] delegate:self indicatorType:FSIndicatorTypeEqualTitle];
    titleView.titleSelectColor = CommonBlue;
    titleView.indicatorColor = CommonBlue;
    [self.contentView addSubview:titleView];
    return self;
}


- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    
}

+ (CGFloat)cellHeight{
    return PXGet375Width(67) + 2;
}
@end
