//
//  LoginRequest.h
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/14.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^successBlock)(void);
typedef void(^failedBlock)(NSString* reason);

@interface LoginRequest : NSObject

+ (void)loginWithUsernName:(NSString*)userName andPassWord:(NSString *)pass WithSUccessBlock:(successBlock)successBlock andFailedBlock:(failedBlock)faileBlock;

@end
