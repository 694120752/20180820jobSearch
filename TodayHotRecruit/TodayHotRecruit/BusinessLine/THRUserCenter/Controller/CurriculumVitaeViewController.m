//
//  CurriculumVitaeViewController.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/25.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "CurriculumVitaeViewController.h"
#import "BaseTableView.h"
#import "THRRequestManager.h"
#import "CVTableViewCell.h"

@interface CurriculumVitaeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BaseTableView *listTableView;

/** */
@property (nonatomic, strong) NSArray *experienceList;
@end


@implementation ButtonCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    UIView* lineView = [UIView new];
    lineView.backgroundColor = RGBACOLOR(240, 240, 240, 1);
    [self.contentView addSubview:lineView];
    lineView.sd_layout
    .topSpaceToView(self.contentView, 0)
    .heightIs(PXGet375Width(15))
    .rightSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0);
    
    UIButton* addExpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addExpButton setImage:[UIImage imageNamed:@"blueCross"] forState:UIControlStateNormal];
    [addExpButton setTitle:@"添加工作经历" forState:UIControlStateNormal];
    [self.contentView addSubview:addExpButton];
    addExpButton.sd_layout
    .topSpaceToView(lineView, 0)
    .heightIs(PXGet375Width(80))
    .rightSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0);
    
    return self;
}
@end

@implementation CurriculumVitaeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavi];
    
    // 获取简历详情
    [[[THRRequestManager manager]setDefaultHeader] POST:[HTTP stringByAppendingString:@"/userResume/detail"] parameters:@{@"userID":[UserDetail getUserID]} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DESC
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    [self.view addSubview:self.listTableView];
}

- (void)setUpNavi{
    self.navBarItemView.backgroundColor = CommonBlue;
    self.navBar.backgroundColor = CommonBlue;
    self.navBar.titleLabel.text = @"我的简历";
}

#pragma mark --------- UITbaleViewDelegate && DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // 两个多出来的是描述
    return self.experienceList.count + 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger lastCount = self.experienceList.count + 2;
    
    
    
    
    if (indexPath.row == 0) {
        // 个人资料
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commonCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"commonCell"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"个人资料";
        return cell;
    }
    
    if (indexPath.row == 1) {
        // 求职期望
    }
    
    
    if (indexPath.row == lastCount) {
        // 添加工作经历
        ButtonCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ButtonCell class])];
        return cell;
    }
    
    
    CVTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CVTableViewCell class])];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     NSUInteger lastCount = self.experienceList.count + 2;
        if (indexPath.row == 0) {
            return PXGet375Width(100);
        }
    
        if (indexPath.row == 1) {
        // 求职期望
            return 0;
        }
    
    
        if (indexPath.row == lastCount) {
        // 添加工作经历
            return PXGet375Width(95);
        }
    
    return [CVTableViewCell cellHeight];
}


#pragma mark -------- lazy

- (BaseTableView *)listTableView{
    if (!_listTableView) {
        _listTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, NavigationBar_Bottom_Y, kScreenWidth, kScreenHeight - NavigationBar_Bottom_Y - Bottom_iPhoneX_SPACE) style:UITableViewStylePlain];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        [_listTableView registerClass:[CVTableViewCell class] forCellReuseIdentifier:NSStringFromClass([CVTableViewCell class])];
        [_listTableView registerClass:[ButtonCell class] forCellReuseIdentifier:NSStringFromClass([ButtonCell class])];
    }
    return _listTableView;
}
@end
