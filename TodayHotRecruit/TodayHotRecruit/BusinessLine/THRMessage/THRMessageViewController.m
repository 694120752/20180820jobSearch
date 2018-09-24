//
//  THRMessageViewController.m
//  TodayHotRecruit
//
//  Created by 张精申 on 2018/8/25.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "THRMessageViewController.h"
#import "THRRequestManager.h"
#import "BaseTableView.h"
@interface THRMessageViewController ()
/** messageList*/
@property(nonatomic,strong)BaseTableView* messageTableView;
@end

@implementation THRMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavi];
    
    
    [[[THRRequestManager manager] setDefaultHeader] POST:[HTTP stringByAppendingString:@"/message/list"] parameters:@{@"pageNo":@"1",@"pageSize":@"10"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DESC
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)setUpNavi{
    self.navBar.titleLabel.text = @"消息";
    self.navBar.backgroundColor = CommonBlue;
    self.navBarItemView.backgroundColor = CommonBlue;
}

@end
