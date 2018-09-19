//
//  THRUploadFile.h
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/19.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
@interface THRUploadFile : NSObject
typedef enum :NSUInteger{
    THRUploadArrayLengthNotEqual,           // 在有文件名的情况下传的文件和标题的个数不相同
    THRUploadNetWorkingError,               // 网络不通
    THRUploadServerError                    // 服务器储存失败
} THRUploadFailedReason;

typedef void(^errorBlock)(NSString* reasonStr,THRUploadFailedReason reason);
typedef void(^progressBlock)(float progress);
typedef void(^uploadSuccess)(NSString* filePath);

+ (void)upLoadFileWithData:(NSArray <NSData*>*)fileData andTitleArray:(NSArray <NSString*>*)titleArray UploadFailedReason:(errorBlock)errorBlock UploadProgressBlock:(progressBlock)progressblock UploadSuccessBlock:(uploadSuccess)successBlock;



@end
