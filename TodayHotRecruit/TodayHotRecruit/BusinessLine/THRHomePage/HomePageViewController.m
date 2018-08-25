//
//  HomePageViewController.m
//  TodayHotRecruit
//
//  Created by 张精申 on 2018/8/25.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "HomePageViewController.h"
#import "BaseTableView.h"
@interface HomePageViewController ()

/** 主体tableView*/
@property(nonatomic,strong)BaseTableView* tableView;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    
}


#pragma mark ---- lazy

-(BaseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, NavigationBar_Bottom_Y, kScreenWidth, kScreenHeight - NavigationBar_Bottom_Y - 44) style:UITableViewStylePlain];
        
    }
    
    return _tableView;
}

@end
