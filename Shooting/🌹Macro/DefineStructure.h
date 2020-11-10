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

typedef enum : NSUInteger {
    originType_Apple = 0,
    originType_Android,
    originType_H5
} originType;

/// 登陆权限校验判断类型
typedef enum : NSUInteger {
    ///评论
    MKLoginAuthorityType_Conment = 0,
    ///抖币转余额
    MKLoginAuthorityType_Money,
    ///提现
    MKLoginAuthorityType_Reflect,
    ///上传视频,
    MKLoginAuthorityType_Upload
} MKLoginAuthorityType;

#endif /* DefineStructure_h */
