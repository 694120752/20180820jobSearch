//
//  BBSModel.m
//  TodayHotRecruit
//
//  Created by 欧金龙 on 2018/9/21.
//  Copyright © 2018年 sn_zjs. All rights reserved.
//

#import "BBSModel.h"

@implementation BBSModel


+ (BBSModel *)encodeFromDic:(NSDictionary *)dic{
    BBSModel *model = [[BBSModel alloc]init];
    model.bbsID = EncodeStringFromDic(dic, @"id");
    model.userID = EncodeStringFromDic(dic, @"userID");
    model.parentID = EncodeStringFromDic(dic, @"categoryID");
    model.avatar = EncodeStringFromDic(dic, @"portraitRequestUrl");
    model.nickName = EncodeStringFromDic(dic, @"userNickName");
    //是否已关注发帖人，0-否，1-是
    model.isFollowed = [EncodeNumberFromDic(dic, @"concernFlag") integerValue] == 0?NO:YES;
    model.content = EncodeStringFromDic(dic, @"content");
    model.pics = EncodeArrayFromDic(dic, @"fileList");
    model.likeFlag = ([EncodeNumberFromDic(dic, @"likeFlag") integerValue] == 0)?NO:YES;
    model.shareCount = [EncodeNumberFromDic(dic, @"shareCount") integerValue];
    model.commentCount = [EncodeNumberFromDic(dic, @"commentCount") integerValue];
    model.likeCount = [EncodeNumberFromDic(dic, @"likeCount") integerValue];
    return model;
}
+(NSArray *)getTempModels {
    BBSModel* m1 = [[BBSModel alloc] init];
    m1.avatar = @"http://b-ssl.duitang.com/uploads/item/201408/08/20140808171354_XkhfE.jpeg";
    m1.content = @"大社群设计师提供高顺准的行业设计讲座和领先的设计资讯分享。为设计师发声，替好作品说话，是平台的运营宗旨。";
    m1.nickName = @"王晓丽";
    m1.isFollowed = true;
    m1.pics = @[@"http://upload.gezila.com/data/20161121/26881479693763.jpg",@"http://a.hiphotos.baidu.com/image/pic/item/9358d109b3de9c82c178468c6181800a19d84397.jpg", @"http://d.hiphotos.baidu.com/image/pic/item/e61190ef76c6a7ef55757931f0faaf51f3de6652.jpg"];
    m1.comments = [self getComments];
    
    BBSModel* m2 = [[BBSModel alloc] init];
    m2.avatar = @"http://p1.qqyou.com/touxiang/UploadPic/2014-12/13/2014121313414466278.jpeg";
    m2.content = @"大社群设计师提供高顺准的行业设计";
    m2.nickName = @"王晓丽";
    m2.isFollowed = true;
    m2.pics = @[@"http://d.hiphotos.baidu.com/image/pic/item/e61190ef76c6a7ef55757931f0faaf51f3de6652.jpg"];
    
    
    BBSModel* m3 = [[BBSModel alloc] init];
    m3.avatar = @"http://p1.qqyou.com/touxiang/UploadPic/2014-12/13/2014121313414466278.jpeg";
    m3.content = @"大社群设计师提供高顺准的行业设计";
    m3.nickName = @"王晓丽";
    m3.isFollowed = false;
    m3.comments = [self getComments];
    
    BBSModel* m4 = [[BBSModel alloc] init];
    m4.avatar = @"http://b-ssl.duitang.com/uploads/item/201408/08/20140808171354_XkhfE.jpeg";
    m4.content = @"大社群设计师提供高顺准的行业设计讲座和领先的设计资讯分享。为设计师发声，替好作品说话，是平台的运营宗旨。";
    m4.nickName = @"王晓丽";
    m4.isFollowed = true;
    
    
    BBSModel* m5 = [[BBSModel alloc] init];
    m5.avatar = @"http://p1.qqyou.com/touxiang/UploadPic/2014-12/13/2014121313414466278.jpeg";
    m5.content = @"大社群设计师提供高顺准的行业设计";
    m5.nickName = @"王晓丽";
    m5.isFollowed = false;
    m5.pics = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537901881816&di=e0e4de2eaf85155c2f794134171f7eeb&imgtype=jpg&src=http%3A%2F%2Fimg4.imgtn.bdimg.com%2Fit%2Fu%3D520741104%2C4013379339%26fm%3D214%26gp%3D0.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537901926859&di=53cd0f2a930ff3b76777c76d95b892fe&imgtype=0&src=http%3A%2F%2Fimg3.redocn.com%2Ftupian%2F20140913%2Fyouxizhanbolanhuimeinv_3057847.jpg"];
    
    BBSModel* m6 = [[BBSModel alloc] init];
    m6.avatar = @"http://b-ssl.duitang.com/uploads/item/201408/08/20140808171354_XkhfE.jpeg";
    m6.content = @"大社群设计师提供高顺准的行业设计讲座和领先的设计资讯分享。为设计师发声，替好作品说话，是平台的运营宗旨。";
    m6.nickName = @"王晓丽";
    m6.isFollowed = true;
    
    BBSModel* m7 = [[BBSModel alloc] init];
    m7.avatar = @"http://p1.qqyou.com/touxiang/UploadPic/2014-12/13/2014121313414466278.jpeg";
    m7.content = @"大社群设计师提供高顺准的行业设计";
    m7.nickName = @"王晓丽";
    m7.isFollowed = false;
    m7.pics = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537901926859&di=53cd0f2a930ff3b76777c76d95b892fe&imgtype=0&src=http%3A%2F%2Fimg3.redocn.com%2Ftupian%2F20140913%2Fyouxizhanbolanhuimeinv_3057847.jpg"];
    
    BBSModel* m8 = [[BBSModel alloc] init];
    m8.avatar = @"http://b-ssl.duitang.com/uploads/item/201408/08/20140808171354_XkhfE.jpeg";
    m8.content = @"大社群设计师提供高顺准的行业设计讲座和领先的设计资讯分享。为设计师发声，替好作品说话，是平台的运营宗旨。";
    m8.nickName = @"王晓丽";
    m8.isFollowed = true;
    
    return @[m1,m2,m3,m4,m5,m6,m7,m8];
    
}


+(NSArray*)getComments {
    CommentModel* c1 = [[CommentModel alloc] init];
    c1.nickName = @"用户001";
    c1.avatar = @"http://b-ssl.duitang.com/uploads/item/201408/08/20140808171354_XkhfE.jpeg";
    c1.content = @"这是一条评论";
    
    CommentModel* c2 = [[CommentModel alloc] init];
    c2.nickName = @"用户002";
    c2.avatar = @"http://p1.qqyou.com/touxiang/UploadPic/2014-12/13/2014121313414466278.jpeg";
    c2.content = @"这是一条评论,但是这条评论比较长，比较长，比较长，比较长比较长长长长长的的评论123123123123";
    
    CommentModel* c3 = [[CommentModel alloc] init];
    c3.nickName = @"用户003";
    c3.avatar = @"http://d.hiphotos.baidu.com/image/pic/item/e61190ef76c6a7ef55757931f0faaf51f3de6652.jpg";
    c3.content = @"这是另一条评论，这条评论不是很长";
    
    return @[c1,c2,c3];
}
@end
