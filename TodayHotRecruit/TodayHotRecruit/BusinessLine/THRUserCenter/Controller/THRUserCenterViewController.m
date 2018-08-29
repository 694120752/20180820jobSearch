//
//  THRUserCenterViewController.m
//  TodayHotRecruit
//
//  Created by 张精申 on 2018/8/25.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "THRUserCenterViewController.h"

// tableViewCell
#import "BaseTableView.h"
#import "BaseTableViewCell.h"
#import "UserHeaderLineTableViewCell.h"
#import "UserCenterTableViewCell.h"

@interface THRUserCenterViewController () <UITableViewDataSource,UITableViewDelegate>
// 主体tableView
@property (nonatomic, strong) BaseTableView *contentTableView;
@end

@implementation THRUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.contentTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            UserHeaderLineTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UserHeaderLineTableViewCell class])];
            
            return cell;
        }
            break;
            
        default:{
            BaseTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BaseTableViewCell class])];
            return cell;
        }
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            //头图
            return [UserHeaderLineTableViewCell selfHeight];
        }
            break;
            
        case 3:
        {
            //广告
            return 0;
        }
            
        default:
            return 0;
            break;
    }
}


#pragma mark ---- lazy
-(BaseTableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - Bottom_iPhoneX_SPACE) style:UITableViewStylePlain];
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        
        [_contentTableView registerClass:[UserHeaderLineTableViewCell class] forCellReuseIdentifier:NSStringFromClass([UserHeaderLineTableViewCell class])];
        [_contentTableView registerClass:[UserCenterTableViewCell class] forCellReuseIdentifier:NSStringFromClass([UserCenterTableViewCell class])];
        [_contentTableView registerClass:[BaseTableViewCell class] forCellReuseIdentifier:NSStringFromClass([BaseTableViewCell class])];
        
    }
    return _contentTableView;
}

@end
