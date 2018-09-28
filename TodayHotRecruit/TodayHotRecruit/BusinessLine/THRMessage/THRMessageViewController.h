//
//  THRMessageViewController.h
//  TodayHotRecruit
//
//  Created by 张精申 on 2018/8/25.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseTableViewCell.h"

@interface THRMessageViewController : BaseViewController

@end

@interface MessageCell : BaseTableViewCell
/** titleLabel*/
@property (nonatomic, strong) UILabel *messageTitle;
/** contentLabel*/
@property (nonatomic, strong) UILabel *messageContent;
/** messageDic*/
@property (nonatomic, strong) NSDictionary *messageDic;


+ (CGFloat)cellHeightWithMessageDic:(NSDictionary *)dic;
@end
