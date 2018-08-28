//
//  NSDate
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/8/28.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Helper)



+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)formatString;

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)formatString;


+(NSInteger) daysFromDate:(NSDate*)fromDate toDate:(NSDate*)toDate;

//add by snping :get the weekday of a special date
// return : a string ex: 周三
+(NSString *)getWeekdayByDate:(NSDate *)date;

// yyyy-MM-dd HH:mm:ss
+ (NSString *)timeFormart:(NSString *)formartString;

+ (NSString *)nowTimeStringWithFormart:(NSString *)formart;

+ (NSString *)stringdateFromString:(NSDate  *)string withFormat:(NSString *)formatString;


@end
