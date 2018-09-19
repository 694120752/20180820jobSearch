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
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    
    [manager POST:[HTTP stringByAppendingString:@"/file/uploadFile"] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (IsArrEmpty(titleArray)) {
            for (NSData* tempData in fileData) {
                [formData appendPartWithFormData:tempData name:@"file"];
            }
        }else{
            for (NSUInteger i = 0; i< fileData.count ; i++) {
                [formData appendPartWithFormData:fileData[i] name:titleArray[i]];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progressblock(1.0 * (uploadProgress.completedUnitCount / uploadProgress.totalUnitCount));
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DESC
        NSString* filePath = EncodeStringFromDic(resultDic, @"filePath");
        if (IsStrEmpty(filePath)) {
            errorBlock(desc,THRUploadServerError);
        }else{
            successBlock(filePath);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error.description,THRUploadNetWorkingError);
    }];
    
  
}

//+ (void)sdsdsdsd:(NSData*)imageData{
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer.timeoutInterval = 20;
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
//
//    NSString* url = @"http://47.105.48.3/job.api/file/uploadFile";
//    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//
//
//        NSDate* date = [NSDate date];
//        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//        formatter.dateFormat = @"yyyyMMddHHmmss";
//        NSString* fileName = [[formatter stringFromDate:date] stringByAppendingString:@".jpeg"];
//        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"]; //
//
//
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//        //上传进度
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            NSLog(@"progress is %@",uploadProgress);
//        });
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        NSLog(@"success");
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        NSLog(@"failed");
//
//    }];
//
//}
@end
