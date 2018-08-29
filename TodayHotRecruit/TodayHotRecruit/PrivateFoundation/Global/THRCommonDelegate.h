//
//  THRCommonDelegate.h
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/8/27.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SelectDto.h"

@protocol THRCommonDelegate <NSObject>

@optional
// icon 点击
- (void)selectIconWithIndex:(NSInteger)index;

// banner 点击
-(void)selectBannerIndex:(NSInteger)index;

// Dto
- (void)selectWithDto:(SelectDto*)selectDto;
@end