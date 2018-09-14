//
//  FindPassRequest.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/14.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "FindPassRequest.h"
#import "THRRequestManager.h"

@implementation FindPassRequest
- (void)findPassWithUserName:(NSString* )userName andSmsCode:(NSString* )smsCode andPassWord:(NSString *)passWord success:(successBlock)successBlock  failed:(failedBlock)failedBlock{
    THRRequestManager* manager = [THRRequestManager manager];
    
    [manager setHeaderDic:@{@"x-s-loginName":userName}];
    
    [manager POST:[HTTP stringByAppendingString:@"/user/updatePassword"] parameters:@{@"userName":userName,@"smsCode":smsCode,@"password":passWord} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DESC
        if (!IsStrEmpty(desc) && [desc isEqualToString:@"success"]) {
            successBlock();
        }else{
            failedBlock(desc);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failedBlock(@"网络不通");
    }];
    
}
@end
