//
//  BaseTableViewCell.h
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/8/27.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THRCommonDelegate.h"
@interface BaseTableViewCell : UITableViewCell
@property (nonatomic, weak) id<THRCommonDelegate> delegate;

- (void)upDateData;
@end
