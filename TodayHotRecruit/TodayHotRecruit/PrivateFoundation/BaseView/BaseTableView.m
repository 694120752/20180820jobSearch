//
//  BaseTableView.m
//  TodayHotRecruit
//
//  Created by zjs on 2018/8/24.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.scrollsToTop = YES;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.multipleTouchEnabled = NO;
        self.estimatedRowHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11.0, *))
        {
            if ([self respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)])
            {
                self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }
        }
    }
    
    return self;
}

@end
