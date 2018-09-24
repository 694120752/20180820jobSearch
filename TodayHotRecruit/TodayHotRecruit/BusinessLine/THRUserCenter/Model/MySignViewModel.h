//
//  MySignViewModel.h
//  TodayHotRecruit
//
//  Created by 张精申 on 2018/9/24.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    RefreshHeader,
    RefreshFooter,
} ComponentPart;
@interface MySignViewModel : NSObject
/** pageNumber*/
@property(nonatomic,assign)NSUInteger pageNumber;
/** size*/
@property(nonatomic,assign)NSUInteger pageSize;
/** dataSource*/
@property(nonatomic,strong)NSMutableArray* dataArray;
@end
