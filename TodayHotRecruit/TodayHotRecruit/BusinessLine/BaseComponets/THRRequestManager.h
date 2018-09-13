//
//  THRRequestManager.h
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/13.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
@interface THRRequestManager : AFHTTPSessionManager
+ (instancetype)manager;
@end
