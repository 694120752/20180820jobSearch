//
//  THRCompany.h
//  TodayHotRecruit
//
//  Created by 张精申 on 2018/9/16.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import <Foundation/Foundation.h>
//address = "\U5357\U4eac\U5e02\U5feb\U9012\U65af\U8482\U82ac";
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
@interface THRCompany : NSObject

@property(nonatomic,strong)NSString* address;
@property(nonatomic,strong)NSString* city;
@property(nonatomic,strong)NSString* cityName;
@property(nonatomic,strong)NSString* contacts;
@property(nonatomic,strong)NSString* cover;
@property(nonatomic,strong)NSString* coverRequestUrl;
@property(nonatomic,strong)NSString* createTime;
@property(nonatomic,strong)NSString* id;
@property(nonatomic,strong)NSString* name;
@property(nonatomic,strong)NSString* province;
@property(nonatomic,strong)NSString* provinceName;
@property(nonatomic,strong)NSString* route;
@property(nonatomic,strong)NSString* servicePhone;
@property(nonatomic,strong)NSString* telphone;

@end
