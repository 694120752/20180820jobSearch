//
//  UserDetail.h
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/18.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^UserDetailRefreshSuccess)(void);
typedef void(^UserDetailRefreshFailed)(NSString* reason);
#define UserCenterRefresh @"UserCenterRefresh"
@interface UserDetail : NSObject

// ignore result
+ (void)refreshUserDetail;

+ (NSDictionary*)getDetail;

+ (NSString*)getUserID;

+ (instancetype)sharedInstance;

+ (void)refreshUserDetailWith:(UserDetailRefreshSuccess)successBlock andFailedBlock:(UserDetailRefreshFailed)failedBlock;

@end
