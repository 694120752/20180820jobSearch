//
//  THRJob.h
//  TodayHotRecruit
//
//  Created by 张精申 on 2018/9/16.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THRCompany.h"
//
//{
//    browseAdd = "";
//    browseCount = 0;
//    code = "";
//    company =     {
//        address = "\U5357\U4eac\U5e02\U5feb\U9012\U65af\U8482\U82ac";
//        city = 320100;
//        cityName = "\U5357\U4eac\U5e02";
//        contacts = 22;
//        cover = "/company/d08f6e71-60ab-4adf-8dde-e16df23a2990.jpg";
//        coverRequestUrl = "http://47.105.48.3/f/company/d08f6e71-60ab-4adf-8dde-e16df23a2990.jpg";
//        createTime = "2018-09-06 23:15";
//        id = 2;
//        name = "\U5927\U6392\U6863";
//        province = 320000;
//        provinceName = "\U6c5f\U82cf\U7701";
//        route = "";
//        servicePhone = 2323;
//        telphone = 2323;
//    };
//    companyID = 2;
//    cover = "";
//    coverUrl = "";
//    createTime = "2018-09-07 18:18";
//    delFlag = 0;
//    employmentDesc = "";
//    id = 5;
//    keyword = "";
//    lodgingDesc = "";
//    name = "\U5b89\U535723232222222222";
//    otherDesc = "";
//    positionDesc = "";
//    salary = 234;
//    salaryDesc = "";
//    signAdd = "";
//    signCount = 0;
//    status = 0;
//    subsidy = 234;
//    subsidyDesc = 234;
//    tagList =     (
//                   "\U9ad8\U798f\U5229"
//                   );
//    tags = 6;
//}

@interface THRJob : NSObject

@property(nonatomic,strong)NSString* browseAdd;
@property(nonatomic,strong)NSString* browseCount;
@property(nonatomic,strong)NSString* code;
@property(nonatomic,strong)THRCompany* company;
@property(nonatomic,strong)NSString* companyID;
@property(nonatomic,strong)NSString* cover;
@property(nonatomic,strong)NSString* coverUrl;
@property(nonatomic,strong)NSString* createTime;
@property(nonatomic,strong)NSString* delFlag;
@property(nonatomic,strong)NSString* employmentDesc;
@property(nonatomic,strong)NSString* id;
@property(nonatomic,strong)NSString* keyword;
@property(nonatomic,strong)NSString* lodgingDesc;
@property(nonatomic,strong)NSString* name;
@property(nonatomic,strong)NSString* otherDesc;
@property(nonatomic,strong)NSString* positionDesc;
@property(nonatomic,strong)NSString* salary;
@property(nonatomic,strong)NSString* salaryDesc;
@property(nonatomic,strong)NSString* signAdd;
@property(nonatomic,strong)NSString* signCount;
@property(nonatomic,strong)NSString* status;
@property(nonatomic,strong)NSString* subsidy;
@property(nonatomic,strong)NSString* subsidyDesc;
@property(nonatomic,strong)NSArray* tagList;
@property(nonatomic,strong)NSString* tags;

@end
