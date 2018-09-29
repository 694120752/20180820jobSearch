//
//  WebViewController.m
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/29.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
/** webView*/
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.backgroundColor = CommonBlue;
    self.navBarItemView.backgroundColor = CommonBlue;
    self.navBar.titleLabel.text = @"转盘抽奖";
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, NavigationBar_Bottom_Y, kScreenWidth, kScreenHeight - NavigationBar_Bottom_Y)];
    NSURL* url =[NSURL URLWithString:[NSString stringWithFormat:@"http://api.njyzdd.com/h5/draw.html?u=%@",[UserDetail getUserID]]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:self.webView];
}

@end
