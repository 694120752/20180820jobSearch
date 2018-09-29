//
//  BBSModel.h
//  TodayHotRecruit
//
//  Created by 欧金龙 on 2018/9/21.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBSModel : NSObject
/**
 头像 url
 */
@property (nonatomic, strong)NSString* avatar;

/**
 昵称
 */
@property (nonatomic, strong)NSString* nickName;

/**
 是否关注
 */
@property (nonatomic, assign)BOOL isFollowed;

/**
 主要内容
 */
@property (nonatomic, strong)NSString* content;

/**
 图片信息
 */
@property (nonatomic, strong)NSArray* pics;


/**
 评论
 */
@property (nonatomic, strong)NSArray* comments;
/**
 附加属性 显示评论
 */
@property (nonatomic, assign)BOOL isShowComment;
+(NSArray*)getTempModels;


+(NSArray*)getTempModels2;
@end
