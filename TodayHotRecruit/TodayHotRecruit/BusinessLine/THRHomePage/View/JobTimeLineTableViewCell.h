//
//  JobTimeLineTableViewCell.h
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/30.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface JobTimeLineTableViewCell : BaseTableViewCell
+ (CGFloat)cellHeightWithContent:(NSString *)content;

- (void)updateWithArray:(NSArray *)sub andContent:(NSString *)content;

@end
