//
//  BBSBaseView.h
//  TodayHotRecruit
//
//  Created by 欧金龙 on 2018/9/20.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BBSBaseView;
@protocol BBSBaseViewDataSource <NSObject>
-(NSArray*)dataSourceArrayForRefreshingDataBBSBaseViewDataSource:(BBSBaseView*)baseView;
@end
@interface BBSBaseView : UIView
@property (nonatomic,weak)id<BBSBaseViewDataSource> dataSource;
-(void)reloadData;
@end
