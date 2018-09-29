//
//  BBSBaseViewController.h
//  TodayHotRecruit
//
//  Created by 欧金龙 on 2018/9/25.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BBSBaseViewController;
@protocol BBSBaseViewControllerDataSource <NSObject>
-(NSArray*)datasourceForBBSBaseViewController:(BBSBaseViewController*)BBSBaseViewController;
-(void)BBSBaseViewControllerDidRefreshData:(BBSBaseViewController*)BBSBaseViewController;
@end
@interface BBSBaseViewController : UIViewController
@property (nonatomic, weak)id <BBSBaseViewControllerDataSource>dataSource;
-(void)reloadData;
@property (nonatomic, strong)NSArray* tableDataSource;

@end
