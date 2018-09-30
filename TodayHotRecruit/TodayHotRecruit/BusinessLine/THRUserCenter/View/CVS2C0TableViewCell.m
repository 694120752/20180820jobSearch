//
//  CVS2C0TableViewCell.m
//  TodayHotRecruit
//
//  Created by 姚凯 on 2018/9/30.
//  Copyright © 2018 sn_zjs. All rights reserved.
//

#import "CVS2C0TableViewCell.h"

@implementation CVS2C0TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)clickBtn:(UIButton *)sender {
    if (self.btnClicked) {
        self.btnClicked(sender.tag);
    }
}


-(void)setModel:(NSDictionary *)model{
    _model = model;
    NSLog(@"%@",model);
    self.companyName.text = _model[@"companyName"];
    self.job.text = _model[@"position"];
    NSString *beginDate = _model[@"beginDate"];
    NSString *endDate = _model[@"endDate"];
    if (beginDate.length != 0 || endDate.length != 0) {
        self.time.text = [NSString stringWithFormat:@"%@至%@",beginDate,endDate];
    }else{
        self.time.text = @"";
    }
    self.money.text = [NSString stringWithFormat:@"%@",_model[@"salary"]];
}
@end
