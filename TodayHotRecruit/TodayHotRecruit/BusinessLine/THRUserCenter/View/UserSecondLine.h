//
//  UserSecondLine.h
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/8/29.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserSecondLine : UIView
@property (weak, nonatomic) IBOutlet UILabel *scoreTitle;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UILabel *fd;
@property (weak, nonatomic) IBOutlet UILabel *fdTitle;
@property (weak, nonatomic) IBOutlet UILabel *contitle;
//顾问按钮
@property (weak, nonatomic) IBOutlet UIButton *conButton;

@property (weak, nonatomic) IBOutlet UIButton *myScore;
@property (weak, nonatomic) IBOutlet UIButton *myFd;

@end
