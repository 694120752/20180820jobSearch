//
//  JobTableViewCell.h
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/8/28.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "THRJob.h"

@interface SubsidizeButton : UIButton

// topLabel
@property (nonatomic, strong) UILabel *topLabel;
// 价格
@property (nonatomic, strong) UILabel *priceLabel;
@end

@interface JobTableViewCell : BaseTableViewCell

@property (nonatomic, strong) THRJob *job;

- (void)mySignWithJob:(THRJob *)job;

- (void)detailWithJob:(THRJob *)job;

+ (CGFloat)selfHeight;

+ (CGFloat)cellHeightInMySign;

+ (CGFloat)cellHeightInDetail;
@end
