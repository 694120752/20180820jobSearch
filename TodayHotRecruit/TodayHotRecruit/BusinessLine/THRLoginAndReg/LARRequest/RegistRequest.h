//
//  RegistRequest.h
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/13.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^RegistSuccessBlock)(void);
typedef void(^RegistFailedBlock)(NSString* reason);

@interface RegistRequest : NSObject
- (void)registWith:(NSString* )userName andPassWord:(NSString *)passWord andSmsCode:(NSString *)smsCode WithSuccessBLock:(RegistSuccessBlock)success andFailedBlock:(RegistFailedBlock)failed;
@end
