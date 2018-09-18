//
//  UserDetail.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/18.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "UserDetail.h"
#import "THRRequestManager.h"
#import "BaseToast.h"

static UserDetail* userDetail = nil;

@interface UserDetail()
@property (nonatomic, strong) NSDictionary *uDict;
@end

@implementation UserDetail
+ (void)refreshUserDetail{
    
    NSString* uid = [UserDetail getUserID];
    if (IsStrEmpty(uid)) {
        return;
    }
    [[[THRRequestManager manager]setDefaultHeader] POST:[HTTP stringByAppendingString:@"/user/detail"] parameters:@{@"userID":[UserDetail getUserID]} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DESC
        if (!IsStrEmpty(desc) && [desc isEqualToString:@"success"]) {
            [UserDetail sharedInstance].uDict = [resultDic objectForKey:@"user"];
            [[NSNotificationCenter defaultCenter]postNotificationName:UserCenterRefresh object:nil];
        }
    } failure:nil];
}

+ (NSDictionary*)getDetail{
    return [UserDetail sharedInstance].uDict;
}

- (instancetype)init{
    self= [super init];
    self.uDict = [NSDictionary dictionary];
    return self;
}

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userDetail = [[[self class] alloc]init];
    });
    return userDetail;
}

// 不在detail中 存在了UserDefault中 这里为方便做统一处理
+ (NSString*)getUserID{
    NSString* tempID = @"";
    UserDefault
    NSDictionary* info = [ud objectForKey:@"userInfo"];
    if ([info isKindOfClass:[NSDictionary class]]) {
        tempID = [info objectForKey:@"id"];
    }
    return IsStrEmpty(tempID)?@"":tempID;
}

+ (void)refreshUserDetailWith:(UserDetailRefreshSuccess)successBlock andFailedBlock:(UserDetailRefreshFailed)failedBlock{
    NSString* uid = [UserDetail getUserID];
    if (IsStrEmpty(uid)) {
        return;
    }
    [[[THRRequestManager manager]setDefaultHeader] POST:[HTTP stringByAppendingString:@"/user/detail"] parameters:@{@"userID":[UserDetail getUserID]} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DESC
        if (!IsStrEmpty(desc) && [desc isEqualToString:@"success"]) {
            successBlock();
        }else{
            failedBlock(desc);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failedBlock(@"网络原因");
    }];
}

@end
