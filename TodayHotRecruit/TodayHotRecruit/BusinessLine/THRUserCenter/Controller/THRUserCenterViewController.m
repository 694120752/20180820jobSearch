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
#import "AdTableViewCell.h"

@interface THRUserCenterViewController () <UITableViewDataSource,UITableViewDelegate>
// 主体tableView
@property (nonatomic, strong) BaseTableView *contentTableView;
@end

@implementation THRUserCenterViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CommmonBlue;
    self.navBar.hidden = YES;
    [self.view addSubview:self.contentTableView];
    
    //依据是否是iphoneX 判断顶上要不要留白
    if (!iPhoneX) {
        self.contentTableView.top = 20;
    }
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
            
        case 3:
        {
            //广告
            AdTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AdTableViewCell class])];
            return cell;
        }
            
        default:{
            // 普通的cell
            UserCenterTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UserCenterTableViewCell class])];
            cell.titleIndex = indexPath.row;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
           
        }
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
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
            return [AdTableViewCell selfHeight];
        }
            
        default:
            return [UserCenterTableViewCell selfHeight];
            break;
    }
}


#pragma mark ---- lazy
-(BaseTableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, Top_iPhoneX_SPACE, kScreenWidth, kScreenHeight - Bottom_iPhoneX_SPACE) style:UITableViewStylePlain];
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        
        [_contentTableView registerClass:[UserHeaderLineTableViewCell class] forCellReuseIdentifier:NSStringFromClass([UserHeaderLineTableViewCell class])];
        [_contentTableView registerClass:[UserCenterTableViewCell class] forCellReuseIdentifier:NSStringFromClass([UserCenterTableViewCell class])];
        [_contentTableView registerClass:[BaseTableViewCell class] forCellReuseIdentifier:NSStringFromClass([BaseTableViewCell class])];
        [_contentTableView registerClass:[AdTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AdTableViewCell class])];
        
    }
    return _contentTableView;
}

@end
