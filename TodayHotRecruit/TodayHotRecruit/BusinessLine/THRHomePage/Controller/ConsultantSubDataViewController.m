//
//  ConsultantSubDataViewController.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/3.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//  专属顾问 下面的个人资料

#import "ConsultantSubDataViewController.h"
#import "BaseTableView.h"
#import "ExPersonalDataTableViewCell.h"

@interface ConsultantSubDataViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ConsultantSubDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //主体tableView
    BaseTableView* base = [[BaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    base.dataSource = self;
    base.delegate = self;
    [base registerClass:[ExPersonalDataTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ExPersonalDataTableViewCell class])];
    [self.view addSubview:base];
    
    base.sd_layout
    .topSpaceToView(self.view, PXGet375Width(0))
    .bottomSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0);
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExPersonalDataTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ExPersonalDataTableViewCell class])];
    switch (indexPath.row) {
        case 0:{
            cell.leftStr = @"个性签名";
            cell.contentStr = @"超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试";
        }
            break;
        case 1:{
            cell.leftStr = @"所在家乡";
            cell.contentStr = @"测试";
        }
            break;
            
        default:{
            cell.leftStr = @"所在城市";
            cell.contentStr = @"测试";
}
            break;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            return [ExPersonalDataTableViewCell selfHeightWithStr:@"超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试超长测试"];
        }
            
            break;
            
        default:{
            return [ExPersonalDataTableViewCell selfHeightWithStr:@"测试"];
        }
            break;
    }
}

@end
