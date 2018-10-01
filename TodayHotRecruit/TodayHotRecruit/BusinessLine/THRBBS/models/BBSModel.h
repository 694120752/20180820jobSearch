//
//  BBSModel.h
//  TodayHotRecruit
//
//  Created by 欧金龙 on 2018/9/21.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentModel.h"

@interface BBSModel : NSObject

/** id*/
@property (nonatomic, strong) NSString *bbsID;

/** 用户id*/
@property (nonatomic, strong) NSString *userID;

/** 父类ID*/
@property (nonatomic, strong) NSString *parentID;

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

/** 是否已点赞*/
@property (nonatomic, assign) BOOL likeFlag;

/** 分享数量*/
@property (nonatomic, assign) NSUInteger shareCount;

/** 评论数量*/
@property (nonatomic, assign) NSUInteger commentCount;

/** 点赞数量*/
@property (nonatomic, assign) NSUInteger likeCount;
/**
 评论
 */
@property (nonatomic, strong)NSArray<CommentModel *>* comments;
/**
 附加属性 显示评论
 */
@property (nonatomic, assign)BOOL isShowComment;


+ (BBSModel *)encodeFromDic:(NSDictionary *)dic;


@end
