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

#import "THRUserInfoViewController.h"

#import "UITableView+YKHelper.h"
#import "CVS0C0TableViewCell.h"
#import "CVS1C0TableViewCell.h"
#import "CVS1C1TableViewCell.h"
#import "CVS2C0TableViewCell.h"
#import "CVS3C0TableViewCell.h"

#import <BRDatePickerView.h>
#import "BaseToast.h"

@interface CurriculumVitaeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BaseTableView *listTableView;

/** */
@property (nonatomic, strong) NSMutableArray *experienceList;

@property (nonatomic,strong) NSMutableDictionary *exportDic;
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
    [addExpButton setTitle:@"添加工作经历" forState:UIControlStateNormal];
    [addExpButton setTitleColor:CommonBlue forState:UIControlStateNormal];
    [self.contentView addSubview:addExpButton];
    addExpButton.sd_layout
    .topSpaceToView(lineView, 0)
    .heightIs(PXGet375Width(80))
    .rightSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0);
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"blueCross"]];
    [addExpButton addSubview:image];
    
    image.sd_layout
    .rightSpaceToView(addExpButton.titleLabel, 5)
    .centerYEqualToView(addExpButton)
    .widthIs(PXGet375Width(40))
    .heightIs(PXGet375Width(40));
    return self;
}
@end

@implementation CurriculumVitaeViewController

-(void)dealloc{
    NSLog(@"");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavi];
    
    // 获取简历详情
    __weak typeof(self)weakSelf = self;
    [[[THRRequestManager manager]setDefaultHeader] POST:[HTTP stringByAppendingString:@"/userResume/detail"] parameters:@{@"userID":[UserDetail getUserID]} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DESC
        if ([desc isEqualToString:@"success"]) {
            NSDictionary *resultDic = responseObject;
            NSArray *resArr = resultDic[@"experienceList"];
            weakSelf.experienceList = [NSMutableArray arrayWithArray:resArr];
            NSDictionary *resDic = resultDic[@"userResume"];
            weakSelf.exportDic = [[NSMutableDictionary alloc] initWithDictionary:resDic];
            [weakSelf.listTableView reloadData];
            
        }
    } failure:nil];
    [self.view addSubview:self.listTableView];
}

- (void)setUpNavi{
    self.navBarItemView.backgroundColor = CommonBlue;
    self.navBar.backgroundColor = CommonBlue;
    self.navBar.titleLabel.text = @"我的简历";
}

#pragma mark --------- UITbaleViewDelegate && DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 4;
    }
    if (section == 2) {
        return _experienceList.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        //个人资料
        return [self S0C0cellForItemAtIndexPath:indexPath];
    }
    if (indexPath.section == 1) {
        //求职期望
        if (indexPath.row == 0) {
            return [self S1C0cellForItemAtIndexPath:indexPath];
        }else{
            return [self S1C1cellForItemAtIndexPath:indexPath];
        }
    }
    if (indexPath.section == 2) {
        return [self S2C0cellForItemAtIndexPath:indexPath];
    }
    CVS0C0TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CVS3C0TableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (id)S0C0cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CVS1C0TableViewCell *cell = [_listTableView dequeueReusableCellWithIdentifier:@"CVS0C0TableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)S1C0cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CVS1C0TableViewCell *cell = [_listTableView dequeueReusableCellWithIdentifier:@"CVS1C0TableViewCell" forIndexPath:indexPath];
    cell.showLabel.text = @"求职期望";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)S1C1cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CVS1C1TableViewCell *cell = [_listTableView dequeueReusableCellWithIdentifier:@"CVS1C1TableViewCell" forIndexPath:indexPath];
    if (indexPath.row == 1) {
        cell.showLabel.text = @"工作地点";
        cell.infoLabel.text = _exportDic[@"jobAddress"];
    }
    if (indexPath.row == 2) {
        cell.showLabel.text = @"期望岗位";
        cell.infoLabel.text = _exportDic[@"position"];
    }
    if (indexPath.row == 3) {
        cell.showLabel.text = @"期望薪金";
        cell.infoLabel.text = _exportDic[@"salary"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



- (id)S2C0cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CVS2C0TableViewCell *cell = [_listTableView dequeueReusableCellWithIdentifier:@"CVS2C0TableViewCell" forIndexPath:indexPath];
    cell.num.text = [NSString stringWithFormat:@"工作经历%ld",indexPath.row+1];
    cell.model = _experienceList[indexPath.row];
    cell.btnClicked = ^(NSInteger tag) {
        if (tag == 3) {
            //起止时间
            [self changeBeginTime:indexPath.row];
        }else{
            //工厂名称 职位 月薪
            [self changeExperience:indexPath.row AndTag:tag];
        }
    };
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return PXGet375Width(100);
    }
    if(indexPath.section == 1){
        if (indexPath.row == 0) {
            return PXGet375Width(100);
        }
        return PXGet375Width(95);
    }
    if(indexPath.section == 2){
        return PXGet375Width(95) * 5;
    }
    
    return PXGet375Width(95);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        [self goToPersonInfo];
    }
    if (indexPath.section == 1) {
        [self changeExpect:indexPath.row];
    }
    if (indexPath.section == 3) {
        [self addWorkExperience];
    }
}
//跳转个人资料
-(void)goToPersonInfo{
    THRUserInfoViewController *info = [THRUserInfoViewController new];
    [self.navigationController pushViewController:info animated:YES];
}

//修改求职期望
-(void)changeExpect:(NSInteger)tag{
    NSString *tittle;
    NSString *exportKey;
    if (tag==1) {
        tittle = @"工作地点";
        exportKey = @"jobAddress";
    }else if(tag==2){
        tittle = @"期望岗位";
        exportKey = @"position";
    }else{
        tittle = @"期望薪金";
        exportKey = @"salary";
    }
    NSString *placeholderStr = _exportDic[exportKey];
    if (placeholderStr.length == 0) {
        placeholderStr = tittle;
    }
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:tittle message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = placeholderStr;
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *infoStr  = alertVC.textFields.lastObject.text;
        if (!IsStrEmpty(infoStr)) {
            NSDictionary *param = @{@"id":[UserDetail getUserID],
                                    exportKey:infoStr
                                    };
            
            __weak typeof(self)weakSelf = self;
            [[[THRRequestManager manager]setDefaultHeader] POST:[HTTP stringByAppendingString:@"/userResume/edit"] parameters:
             param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 DESC
                 if ([desc isEqualToString:@"success"]) {
                     [BaseToast toast:@"修改成功"];
                     weakSelf.exportDic[exportKey] = infoStr;
                     [weakSelf.listTableView reloadIndexSection:1];
                 }
                 
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 NSLog(@"%@",error);
             }];
        }
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:action1];
    [alertVC addAction:action2];
    [self presentViewController:alertVC animated:YES completion:nil];
}

//修改工作经历
-(void)changeExperience:(NSInteger)row AndTag:(NSInteger)tag {
    //tab 区分说选项  rowx区分在list中下标
    NSString *tittle;
    NSString *experienceKey;
    if (tag==1) {
        tittle = @"工厂名称";
        experienceKey = @"companyName";
    }else if(tag==2){
        tittle = @"职位";
        experienceKey = @"position";
    }else{
        tittle = @"月薪";
        experienceKey = @"salary";
    }
    NSDictionary *dic = _experienceList[row];
    NSMutableDictionary *experienceDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    NSString *placeholderStr = [NSString stringWithFormat:@"%@",experienceDic[experienceKey]];
    if (placeholderStr.length == 0) {
        placeholderStr = tittle;
    }
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:tittle message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = placeholderStr;
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *infoStr  = alertVC.textFields.lastObject.text;
        if (!IsStrEmpty(infoStr)) {
            experienceDic[experienceKey] = infoStr;
            NSDictionary *param = @{@"id":experienceDic[@"id"],
                                    @"userID":[UserDetail getUserID],
                                    @"companyName":experienceDic[@"companyName"],
                                    @"position":experienceDic[@"position"],
                                    @"beginDate":experienceDic[@"beginDate"],
                                    @"endDate":experienceDic[@"endDate"],
                                    @"salary":experienceDic[@"salary"]
                                    };
            __weak typeof(self)weakSelf = self;
            [weakSelf saveExperienceWithParam:param AndRow:row];
        }
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:action1];
    [alertVC addAction:action2];
    [self presentViewController:alertVC animated:YES completion:nil];
}

//修改工作经历 - 起止时间
-(void)changeBeginTime:(NSInteger)row{
    __weak typeof(self)weakSelf = self;
    [BRDatePickerView showDatePickerWithTitle:@"开始时间" dateType:BRDatePickerModeYM defaultSelValue:nil resultBlock:^(NSString *selectValue) {
        [weakSelf changeEndTime:row WithBeginTime:selectValue];
    }];
}
-(void)changeEndTime:(NSInteger)row WithBeginTime:(NSString *)value{
    
    __weak typeof(self)weakSelf = self;
    [BRDatePickerView showDatePickerWithTitle:@"结束时间" dateType:BRDatePickerModeYM defaultSelValue:nil resultBlock:^(NSString *selectValue) {
        NSDictionary *dic = weakSelf.experienceList[row];
        NSMutableDictionary *experienceDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
        experienceDic[@"beginDate"] = [NSString stringWithFormat:@"%@",value];
        experienceDic[@"endDate"] =  [NSString stringWithFormat:@"%@",selectValue];
        NSDictionary *param = @{@"id":experienceDic[@"id"],
                                @"userID":[UserDetail getUserID],
                                @"companyName":experienceDic[@"companyName"],
                                @"position":experienceDic[@"position"],
                                @"beginDate":experienceDic[@"beginDate"],
                                @"endDate":experienceDic[@"endDate"],
                                @"salary":experienceDic[@"salary"]
                                };
        [weakSelf saveExperienceWithParam:param AndRow:row];
        
    }];
}
//添加工作经历
-(void)addWorkExperience{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"id",@"",@"companyName",@"",@"position",@"",@"beginDate",@"",@"endDate",@"",@"salary", nil];
    [self.experienceList addObject:dic];
    [_listTableView reloadIndexSection:2];
    //    NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:3];  //取最后一行数据
    //    [_listTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}


//设置分区间隔
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return  10;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
    view.backgroundColor = RGBACOLOR(240, 240, 240, 1);
    return  view;
}

#pragma mark - 侧滑
-  (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteExperienceWithID:indexPath.row];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        return YES;
    }
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView*)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}




#pragma mark -------- lazy
- (BaseTableView *)listTableView{
    if (!_listTableView) {
        _listTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, NavigationBar_Bottom_Y, kScreenWidth, kScreenHeight - NavigationBar_Bottom_Y - Bottom_iPhoneX_SPACE) style:UITableViewStylePlain];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        [_listTableView zy_registNibCell:[CVS0C0TableViewCell class]];
        [_listTableView zy_registNibCell:[CVS1C0TableViewCell class]];
        [_listTableView zy_registNibCell:[CVS1C1TableViewCell class]];
        [_listTableView zy_registNibCell:[CVS2C0TableViewCell class]];
        [_listTableView zy_registNibCell:[CVS3C0TableViewCell class]];
        
    }
    return _listTableView;
}



#pragma mark - http
-(void)saveExperienceWithParam:(NSDictionary *)param AndRow:(NSInteger)row{
    
    __weak typeof(self)weakSelf = self;
    [[[THRRequestManager manager]setDefaultHeader] POST:[HTTP stringByAppendingString:@"/userResume/saveExperience"] parameters:
     param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         DESC
         if ([desc isEqualToString:@"success"]) {
             [BaseToast toast:@"修改成功"];
             NSDictionary *resultDic = responseObject;
             NSDictionary *workEx = resultDic[@"entity"];
             [weakSelf.experienceList removeObjectAtIndex:row];
             [weakSelf.experienceList insertObject:workEx atIndex:row];
             
             [weakSelf.listTableView reloadIndexSection:2];
         }
         
     } failure:nil];
}
//删除工作经验
-(void)deleteExperienceWithID:(NSInteger)row{
    NSString *experienceID = _experienceList[row][@"id"];
    NSDictionary *param = @{@"id":experienceID};
    __weak typeof(self)weakSelf = self;
    [[[THRRequestManager manager]setDefaultHeader] POST:[HTTP stringByAppendingString:@"/userResume/delExperience"] parameters:
     param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         DESC
         if ([desc isEqualToString:@"success"]) {
             [BaseToast toast:@"删除成功"];
             [weakSelf.experienceList removeObjectAtIndex:row];
             [weakSelf.listTableView reloadIndexSection:2];
         }
         
     } failure:nil];
}
@end

