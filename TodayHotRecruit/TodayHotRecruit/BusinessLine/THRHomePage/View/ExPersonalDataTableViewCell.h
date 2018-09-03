//
//  ExPersonalDataTableViewCell.h
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/3.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface ExPersonalDataTableViewCell : BaseTableViewCell

// contentString
@property (nonatomic, strong) NSString *contentStr;

// 左边的标题文字
@property (nonatomic, strong) NSString *leftStr;

+(CGFloat)selfHeightWithStr:(NSString*)str;
@end
