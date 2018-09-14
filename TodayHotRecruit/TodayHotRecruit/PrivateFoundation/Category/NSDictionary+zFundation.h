//
//  NSDictionary+zFundation.h
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/14.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (zFundation)
extern NSString* EncodeStringFromDic(NSDictionary *dic, NSString *key);
/**
 * 如果取不到值，返回自定义的默认值
 @brief defValue 自定义默认值
 **/
extern NSString* _Nonnull  EncodeStringFromDicWithDefValue(NSDictionary *dic, NSString *key, NSString * _Nonnull defValue);
/**
 * 如果取不到值，返回@""
 **/
extern NSString* _Nonnull  EncodeStringFromDicDefEmtryValue(NSDictionary *dic, NSString *key);

extern NSNumber* EncodeNumberFromDic(NSDictionary *dic, NSString *key);
extern NSDictionary *EncodeDicFromDic(NSDictionary *dic, NSString *key);
extern NSArray      *EncodeArrayFromDic(NSDictionary *dic, NSString *key);
extern NSArray      *EncodeArrayFromDicUsingParseBlock(NSDictionary *dic, NSString *key, id(^parseBlock)(NSDictionary *innerDic));

@end
