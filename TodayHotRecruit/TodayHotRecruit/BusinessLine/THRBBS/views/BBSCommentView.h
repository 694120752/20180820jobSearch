//
//  BBSCommentView.h
//  TodayHotRecruit
//
//  Created by 欧金龙 on 2018/9/27.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
@interface BBSCommentView : UIView
@property (nonatomic, strong)NSArray* commentArray;
-(void)setCommentArray:(NSArray*)commentArray isShow:(BOOL)isShow;
@end
