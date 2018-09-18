//
//  THRRequestManager.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/13.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "THRRequestManager.h"


@implementation THRRequestManager

+ (THRRequestManager* )manager{
    THRRequestManager *manager = [super manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    return manager;
}

// 添加请求头文件
- (void)setHeaderDic:(NSDictionary *)headerDic{
    if (headerDic != nil) {
        for (NSString *httpHeaderField in headerDic.allKeys) {
            NSString *value = headerDic[httpHeaderField];
            [self.requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
        }
    }
}

// 添加默认头
- (instancetype)setDefaultHeader{
    UserDefault
    NSString* userName = @"";
    NSDictionary* dic = [ud objectForKey:@"userInfo"];
    if (NotNilAndNull(dic)) {
        userName = [dic objectForKey:@"userName"];
        [self setHeaderDic:@{@"x-s-loginName":userName}];
    }
    return self;
}
@end
