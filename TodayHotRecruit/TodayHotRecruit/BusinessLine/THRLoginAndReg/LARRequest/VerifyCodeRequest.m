//
//  VerifyCodeRequest.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/13.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "VerifyCodeRequest.h"

@interface VerifyCodeRequest()
@property (nonatomic, strong) NSDictionary *arg;
@end

@implementation VerifyCodeRequest

- (void)getCodeWithSource:(VerSource)type andPhoneNumber:(NSString*)number WithResult:(VerSuccessBlock)successBlock andFailedBlock:(VerFailedBlock)failedBlock{
    THRRequestManager *manager = [THRRequestManager manager];
    NSDictionary* paramater = @{
                                @"type":@(type),
                                @"phone":number
                                };
    [manager POST:[HTTP stringByAppendingString:@"/code/sendVerificationCode"] parameters:paramater progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* resultDic = responseObject;
        NSString* desc = [resultDic objectForKey:@"desc"];
        
        if (!IsStrEmpty(desc)  && [desc isEqualToString:@"success"]) {
            successBlock();
        }else{
            failedBlock();
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failedBlock();
    }];
}

-(void)handleWithResult:(BOOL)result{
    if (self.verDelegate && [self.verDelegate respondsToSelector:@selector(verCodeWithResult:)]) {
        [self.verDelegate verCodeWithResult:result];
    }
}


@end
