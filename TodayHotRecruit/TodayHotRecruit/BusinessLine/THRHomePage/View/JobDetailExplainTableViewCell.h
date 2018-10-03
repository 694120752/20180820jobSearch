//
//  JobDetailExplainTableViewCell.h
//  TodayHotRecruit
//
//  Created by 张精申 on 2018/10/3.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "BaseTableViewCell.h"
@interface JobDetailExplainTableViewCell : BaseTableViewCell
- (void)setContent:(NSArray *)contentArray andTitle:(NSString *)title;

+ (CGFloat)cellHeightWithContent:(NSArray *)contentArray;
@end
