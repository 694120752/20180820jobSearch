//
//  RegistRequest.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/13.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "RegistRequest.h"
#import "THRRequestManager.h"


@implementation RegistRequest
- (void)registWith:(NSString* )userName andPassWord:(NSString *)passWord andSmsCode:(NSString *)smsCode WithSuccessBLock:(RegistSuccessBlock)success andFailedBlock:(RegistFailedBlock)failed{
    THRRequestManager *manager = [THRRequestManager manager];
    NSDictionary* parameter = @{
                                @"userName":userName,
                                @"password":passWord,
                                @"smsCode":smsCode
                                };
    [manager POST:[HTTP stringByAppendingString:@"/user/register"] parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary* resultDic = responseObject;
        NSString* desc = [resultDic objectForKey:@"desc"];
        
        if (!IsStrEmpty(desc) && [desc isEqualToString:@"success"]) {
            success();
            
            // 这边存入用户信息
            NSDictionary* userDic = [resultDic objectForKey:@"userInfo"];
            UserDefault
            if ([userDic isKindOfClass:[NSDictionary class]]) {
                [ud setValue:userDic forKey:@"userInfo"];
            }
            
        }else{
            failed(desc);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(@"网络不通");
    }];
}
@end
