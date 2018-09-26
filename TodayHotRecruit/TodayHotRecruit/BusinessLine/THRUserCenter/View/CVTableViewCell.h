//
//  CVTableViewCell.h
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/26.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
@interface CVTableViewCell : BaseTableViewCell
/** expDic*/
@property (nonatomic, strong) NSDictionary *dic;

+ (CGFloat)cellHeight;
@end
