//
//  CVS2C0TableViewCell.h
//  TodayHotRecruit
//
//  Created by 姚凯 on 2018/9/30.
//  Copyright © 2018 sn_zjs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CVS2C0TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UILabel *job;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (nonatomic, copy)void(^btnClicked)(NSInteger tag);
@property(nonatomic,strong) NSDictionary *model;
@end

NS_ASSUME_NONNULL_END
