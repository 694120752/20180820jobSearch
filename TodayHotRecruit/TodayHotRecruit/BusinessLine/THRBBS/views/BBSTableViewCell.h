//
//  BBSTableViewCell.h
//  TodayHotRecruit
//
//  Created by 欧金龙 on 2018/9/21.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBSModel.h"
@class BBSTableViewCell;
@protocol BBSTableViewCellDelegate <NSObject>

/**
 点击 关注 按钮回调

 @param cell cell
 @param bbsModel 模型
 */
-(void)BBSTableViewCell:(BBSTableViewCell*)cell didClickFollowForBBSModel:(BBSModel*)bbsModel;


/**
 点击 评论回调

 @param cell cell
 @param bbsModel model
 */
-(void)BBSTableViewCell:(BBSTableViewCell*)cell didClickCommentForBBSModel:(BBSModel*)bbsModel;


/**
 点赞

 @param cell cell
 @param bbsModel model
 */
- (void)BBSTableViewCell:(BBSTableViewCell*)cell didClickLikeForBBSModel:(BBSModel*)bbsModel;
@end
@interface BBSTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView;

@property (nonatomic, strong)BBSModel* bbsModel;

@property (nonatomic, weak)id<BBSTableViewCellDelegate>delegate;
@end
