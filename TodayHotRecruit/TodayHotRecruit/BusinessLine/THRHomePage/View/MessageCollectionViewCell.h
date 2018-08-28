//
//  MessageCollectionViewCell.h
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/8/28.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCollectionViewCell : UICollectionViewCell
// 主题内容
@property (nonatomic, strong) UILabel *titleContentLabel;

// 右边时间
@property (nonatomic, strong) UILabel *timeLabel;
@end
