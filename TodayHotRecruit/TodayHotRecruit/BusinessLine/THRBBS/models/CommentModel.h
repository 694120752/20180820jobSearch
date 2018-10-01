//
//  CommentModel.h
//  TodayHotRecruit
//
//  Created by 欧金龙 on 2018/9/26.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
@property (nonatomic, strong)NSString* avatar;
@property (nonatomic, strong)NSString* nickName;
@property (nonatomic, strong)NSString* content;
/** userID*/
@property (nonatomic, strong) NSString *userID;

/** id*/
@property (nonatomic, strong) NSString *id;

/** reUserID*/
@property (nonatomic, strong) NSString *reUserID;

/** forumID*/
@property (nonatomic, strong) NSString *forumID;
@end
