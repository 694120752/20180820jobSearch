//
//  BBSCommentView.h
//  TodayHotRecruit
//
//  Created by 欧金龙 on 2018/9/27.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"

@protocol THRCommentDelegate <NSObject>
- (void)subMitCommentWithContent:(NSString *)content;
@end

@interface BBSCommentView : UIView
@property (nonatomic, strong)NSArray* commentArray;
@property (nonatomic, weak) id<THRCommentDelegate> delegate;
-(void)setCommentArray:(NSArray*)commentArray isShow:(BOOL)isShow;
@end
