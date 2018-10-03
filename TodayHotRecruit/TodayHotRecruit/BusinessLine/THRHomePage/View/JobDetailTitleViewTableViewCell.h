//
//  JobDetailTitleViewTableViewCell.h
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/30.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol jobDetailSelectIndexProtocol <NSObject>
- (void)selectWithIndex:(NSUInteger)index;
@end

@interface JobDetailTitleViewTableViewCell : BaseTableViewCell

@property(nonatomic,weak)id<jobDetailSelectIndexProtocol> selectDelegate;
+ (CGFloat)cellHeight;
@end
