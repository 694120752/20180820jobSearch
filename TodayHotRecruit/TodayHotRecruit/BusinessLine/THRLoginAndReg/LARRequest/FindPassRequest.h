//
//  FindPassRequest.h
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/14.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^successBlock)(void);
typedef void(^failedBlock)(NSString* reason);

@interface FindPassRequest : NSObject
- (void)findPassWithUserName:(NSString* )userName andSmsCode:(NSString* )smsCode andPassWord:(NSString *)passWord success:(successBlock)successBlock  failed:(failedBlock)failedBlock;
@end
