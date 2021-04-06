//
//  DefineStructure.h
//  Feidegou
//
//  Created by Kite on 2019/11/21.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//

#ifndef DefineStructure_h
#define DefineStructure_h

#import <UIKit/UIKit.h>
/*
 这个类只放置用户自定义的定义的枚举值
 */
typedef enum : NSInteger {
    DevEnviron_Cambodia_Main = 0,/// 柬埔寨（主要）开发环境
    DevEnviron_Cambodia_Minor,/// 柬埔寨（次要）开发环境
    DevEnviron_Cambodia_Rally,/// 柬埔寨Rally（次要）开发环境
    DevEnviron_China_Mainland,/// 中国大陆开发环境
    TestEnviron,/// 测试环境
    ProductEnviron/// 生产环境
} NetworkingEnvir;
/// 来源:0、苹果；1、安卓；2、H5
typedef enum : NSUInteger {
    originType_Apple = 0,
    originType_Android,
    originType_H5
} originType;
/// 来源:0、系统消息；1、粉丝消息；2、评论消息
typedef enum : NSUInteger {
    DDMsgTBVCellType_SYS = 0,
    DDMsgTBVCellType_Fans,
    DDMsgTBVCellType_Comment
} DDMsgTBVCellType;
///用户发帖的文字显示行数
typedef enum : NSUInteger {
    CollectionViewCell_Style2MsgType_1 = 0,// 3行模式,
    CollectionViewCell_Style2MsgType_2// 全显示模式,
} CollectionViewCell_Style2MsgType;
///用户回帖的文字显示条数
typedef enum : NSUInteger {
    DDCollectionViewCell_Style2LocationUsersList = 0,// 3条模式,用于最外层的用户列表
    DDCollectionViewCell_Style2LocationUserDetail// 全显示模式,用于展示用户详情
} DDCollectionViewCell_Style2Location;

typedef enum : NSUInteger {
    selectedVideoType = 0,// 选择的是视频,
    selectedPicType// 选择的是图片,
} selectedType;

typedef enum : NSInteger {
    FocusOnMe = 0,//关注我的
    FocusOnOthers//我关注别人的
} FocusOnStyle;

typedef enum : NSInteger {
    VIP界面 = 1,
    充值界面,
    上传短视频界面,
    上传帖子界面
} 界面;

#endif /* DefineStructure_h */
