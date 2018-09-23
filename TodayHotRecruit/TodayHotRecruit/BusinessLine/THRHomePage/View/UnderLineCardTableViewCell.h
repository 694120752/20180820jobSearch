//
//  UnderLineCardTableViewCell.h
//  TodayHotRecruit
//
//  Created by sn_zjs on 2018/9/21.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "BaseTableViewCell.h"


@interface OutLineButton:UIButton
@end

@interface UnderLineCardTableViewCell : BaseTableViewCell
/** dataDic*/
@property(nonatomic,strong)NSDictionary* dataDic;

+ (CGFloat)cellHeightWithDic:(NSDictionary *)dataDic;
@end
