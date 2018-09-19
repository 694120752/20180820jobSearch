//
//  THRUploadFile.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/19.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "THRUploadFile.h"

@implementation THRUploadFile
+ (void)upLoadFileWithData:(NSArray <NSData*>*)fileData andTitleArray:(NSArray <NSString*>*)titleArray UploadFailedReason:(errorBlock)errorBlock UploadProgressBlock:(progressBlock)progressblock UploadSuccessBlock:(uploadSuccess)successBlock{
    
    if (!IsArrEmpty(titleArray)) {
        if (fileData.count != titleArray.count) {
            errorBlock(@"ArrayCountError",THRUploadArrayLengthNotEqual);
            return;
        }
    }

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];

    [manager POST:[HTTP stringByAppendingString:@"/file/uploadFile"] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (IsArrEmpty(titleArray)) {
            for (NSData* tempData in fileData) {
                [formData appendPartWithFileData:tempData name:@"file" fileName:@"headImage.jpeg" mimeType:@"image/png"];
            }
        }else{
            for (NSUInteger i = 0; i< fileData.count ; i++) {
                [formData appendPartWithFormData:fileData[i] name:titleArray[i]];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progressblock(1.0 * (uploadProgress.completedUnitCount / uploadProgress.totalUnitCount));
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary*resultDic  =   responseObject;
        NSString* fileUrl      =   EncodeStringFromDic(resultDic, @"fileUrl");
        NSString* msg           =   EncodeStringFromDic(resultDic, @"msg");
        if (IsStrEmpty(fileUrl)) {
            errorBlock(msg,THRUploadServerError);
        }else{
            successBlock(fileUrl);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error.description,THRUploadNetWorkingError);
    }];

}

@end
