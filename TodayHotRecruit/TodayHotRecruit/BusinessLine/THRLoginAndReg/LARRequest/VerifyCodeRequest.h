//
//  VerifyCodeRequest.h
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/13.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//  获取验证码


#import "THRRequestManager.h"
typedef enum :NSUInteger{
    VerCode,
    VerCodeSourceRregist,                 // 注册
    VerCodeSourceLogin,                   //登录
    VerCodeSourceForget                    // 忘记密码
} VerSource;

typedef void(^VerSuccessBlock)(void);
typedef void(^VerFailedBlock)(void);


@protocol VerCodeProtocol <NSObject>
- (void)verCodeWithResult:(BOOL)result;
@end

@interface VerifyCodeRequest : NSObject
@property (nonatomic, weak) id<VerCodeProtocol> verDelegate;

- (void)getCodeWithSource:(VerSource)type andPhoneNumber:(NSString*)number WithResult:(VerSuccessBlock)successBlock andFailedBlock:(VerFailedBlock)failedBlock;
@end
