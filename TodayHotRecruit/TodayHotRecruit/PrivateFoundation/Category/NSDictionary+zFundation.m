//
//  NSDictionary+zFundation.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/14.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "NSDictionary+zFundation.h"

@implementation NSDictionary (zFundation)
NSString* EncodeStringFromDic(NSDictionary *dic, NSString *key)
{
    if (nil != dic
        && [dic isKindOfClass:[NSDictionary class]]) {
        
        id temp = [dic objectForKey:key];
        if ([temp isKindOfClass:[NSString class]])
        {
            return temp;
        }
        else if ([temp isKindOfClass:[NSNumber class]])
        {
            return [temp stringValue];
        }
    }
    
    return nil;
}

/**
 * 如果取不到值，返回自定义的默认值
 @brief defValue 自定义默认值
 **/
NSString* _Nonnull  EncodeStringFromDicWithDefValue(NSDictionary *dic, NSString *key, NSString * _Nonnull defValue){
    NSString *value = EncodeStringFromDic(dic, key);
    if (value) {
        return value;
    }
    return defValue;
}

/**
 * 如果取不到值，返回@""
 **/
NSString* _Nonnull  EncodeStringFromDicDefEmtryValue(NSDictionary *dic, NSString *key){
    return  EncodeStringFromDicWithDefValue(dic, key,@"");
}

NSNumber* EncodeNumberFromDic(NSDictionary *dic, NSString *key)
{
    if (nil != dic
        && [dic isKindOfClass:[NSDictionary class]]) {
        id temp = [dic objectForKey:key];
        if ([temp isKindOfClass:[NSString class]])
        {
            return [NSNumber numberWithDouble:[temp doubleValue]];
        }
        else if ([temp isKindOfClass:[NSNumber class]])
        {
            return temp;
        }
    }
    
    return nil;
}

NSDictionary *EncodeDicFromDic(NSDictionary *dic, NSString *key)
{
    if ([dic respondsToSelector:@selector(objectForKey:)]) {
        id temp = [dic objectForKey:key];
        if ([temp isKindOfClass:[NSDictionary class]])
        {
            return temp;
        }
    }
    
    return nil;
}

NSArray      *EncodeArrayFromDic(NSDictionary *dic, NSString *key)
{
    if (nil != dic
        && [dic isKindOfClass:[NSDictionary class]]) {
        id temp = [dic objectForKey:key];
        if ([temp isKindOfClass:[NSArray class]])
        {
            return temp;
        }
    }
    
    return nil;
}

NSArray      *EncodeArrayFromDicUsingParseBlock(NSDictionary *dic, NSString *key, id(^parseBlock)(NSDictionary *innerDic))
{
    NSArray *tempList = EncodeArrayFromDic(dic, key);
    if ([tempList count])
    {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:[tempList count]];
        for (NSDictionary *item in tempList)
        {
            id dto = parseBlock(item);
            if (dto) {
                [array addObject:dto];
            }
        }
        return array;
    }
    return nil;
}

@end
