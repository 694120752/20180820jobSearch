//
//  THRJobListRequest.h
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/20.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//  职位列表的请求 都放在这里  处理tableView状态

#import "THRRequestManager.h"

typedef void(^SuccessBlock)(NSArray * dataList);

typedef void(^FailedBlock)(NSString* reason);

extern const NSUInteger listPageSize;

@interface THRJobListRequest : THRRequestManager

+ (void)getJobDataWithPage:(NSUInteger)pageNumber andTableView:(UITableView *)listView andSuccess:(SuccessBlock)success andCityID:(NSString *)cityID andKeyWord:(NSString *)keyWord;

@end
