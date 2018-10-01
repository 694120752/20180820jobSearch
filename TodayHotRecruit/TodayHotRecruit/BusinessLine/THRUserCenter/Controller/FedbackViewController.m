//
//  FedbackViewController.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/10/1.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "FedbackViewController.h"
#import "THRRequestManager.h"
#import "BaseToast.h"
@interface FedbackViewController ()
/** textView*/
@property (nonatomic, strong) UITextView *textView;
@end

@implementation FedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavi];
    
    // 添加有边框的view
    UIView *borderView = [UIView new];
    [self.view addSubview:borderView];
    
    borderView.frame = CGRectMake(Get375Width(10), NavigationBar_Bottom_Y + Get375Width(20), kScreenWidth - Get375Width(10) * 2, PXGet375Width(500));
    
    borderView.layer.borderColor = RGBACOLOR(240, 240, 240, 1).CGColor;
    borderView.layer.borderWidth = 1;
    borderView.backgroundColor = [UIColor whiteColor];
    
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(Get375Width(10), Get375Width(10), borderView.width - Get375Width(10) * 2, PXGet375Width(350))];
    _textView = textView;
    textView.backgroundColor = RGBACOLOR(240, 240, 240, 1);
    
    [borderView addSubview:textView];
    
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @"请写下您的意见或建议";
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor darkTextColor];
    [placeHolderLabel sizeToFit];
    [textView addSubview:placeHolderLabel];
    
    
    textView.font = [UIFont systemFontOfSize:13.f];
    placeHolderLabel.font = [UIFont systemFontOfSize:13.f];
    [textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];

    UIButton* submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.layer.cornerRadius = 8;
    [submitButton addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [submitButton setTitle:@"提交建议" forState:UIControlStateNormal];
    submitButton.backgroundColor = CommonBlue;
    
    [borderView addSubview:submitButton];
    submitButton.sd_layout
    .bottomSpaceToView(borderView, Get375Width(10))
    .widthIs(PXGet375Width(260))
    .heightIs(PXGet375Width(80))
    .centerXEqualToView(borderView);
    
    
}


- (void)setUpNavi{
    self.navBar.backgroundColor = CommonBlue;
    self.navBarItemView.backgroundColor = CommonBlue;
    self.navBar.titleLabel.text = @"用户反馈";
    
}

- (void)submitAction{
    if (IsStrEmpty(_textView.text)) {
        return;
    }
    
    [[[THRRequestManager manager] setDefaultHeader] POST:[HTTP stringByAppendingString:@"/feedBack/add"] parameters:@{@"content":_textView.text} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DESC
        if ([desc isEqualToString:@"success"]) {
            [BaseToast toast:@"反馈已收到"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [BaseToast toast:desc];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [BaseToast toast:@"网络不畅"];
    }];
}
@end
