//
//  LoginRequest.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/14.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "LoginRequest.h"
#import "THRRequestManager.h"
#import "UserDetail.h"

@implementation LoginRequest
+ (void)loginWithUsernName:(NSString*)userName andPassWord:(NSString *)pass WithSUccessBlock:(successBlock)successBlock andFailedBlock:(failedBlock)faileBlock{
    THRRequestManager* manager = [THRRequestManager manager];
    [manager POST:[HTTP stringByAppendingString:@"/user/login"] parameters:@{@"userName":userName,@"password":pass} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DESC
        if (!IsStrEmpty(desc) && [desc isEqualToString:@"success"]) {
            successBlock();
            
            /// 本地存一下
            NSDictionary* userDic = [resultDic objectForKey:@"user"];
            UserDefault
            if ([userDic isKindOfClass:[NSDictionary class]]) {
                [ud setValue:userDic forKey:@"userInfo"];
            }
            // 刷新一下用户信息
            [UserDetail refreshUserDetail];
        }else{
            faileBlock(desc);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faileBlock(@"网络不通");
    }];
}
@end
