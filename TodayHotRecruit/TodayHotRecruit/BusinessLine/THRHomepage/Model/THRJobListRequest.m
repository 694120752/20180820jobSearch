//
//  THRJobListRequest.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/20.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "THRJobListRequest.h"
#import "HomePageViewController.h"
#import <MJRefresh.h>
#import "THRJob.h"
#import <MJExtension.h>

NSUInteger const listPageSize = 10;
@implementation THRJobListRequest
+ (void)getJobDataWithPage:(NSUInteger)pageNumber andTableView:(UITableView *)listView andSuccess:(SuccessBlock)success andCityID:(NSString *)cityID andKeyWord:(NSString *)keyWord{
    NSMutableDictionary *paramater = [NSMutableDictionary dictionary];
    
    [paramater setValue:@(pageNumber) forKey:@"pageNo"];
    [paramater setValue:@(listPageSize) forKey:@"pageSize"];
    
    if (!IsStrEmpty(cityID)) {
        [paramater setValue:cityID forKey:@"city"];
    }
    
    if (!IsStrEmpty(keyWord)) {
        [paramater setValue:keyWord forKey:@"keyword"];
    }
    
    [THRRequestManager.manager.setDefaultHeader POST:[HTTP stringByAppendingString:@"/job/list"] parameters:paramater progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray* dataList = @[];
        
        DESC
        if (!IsStrEmpty(desc) && [desc isEqualToString:@"success"]) {
            dataList = [THRJob mj_objectArrayWithKeyValuesArray:[resultDic objectForKey:@"dataList"]];
            success(dataList);
        }
        
        [listView.mj_header endRefreshing];
        
        if (dataList.count < listPageSize) {
            [listView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [listView.mj_footer endRefreshing];
        }
        listView.mj_footer.hidden = NO;
        
        [listView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [listView.mj_header endRefreshing];
        [listView.mj_footer endRefreshing];
        listView.mj_footer.hidden = NO;
    }];
}
@end
