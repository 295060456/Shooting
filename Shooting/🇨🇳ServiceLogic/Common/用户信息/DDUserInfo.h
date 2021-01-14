//
//  DDUserInfo.h
//  DouDong-II
//
//  Created by Jobs on 2020/12/19.
//

#import <Foundation/Foundation.h>
#import "DDUserModel.h"

NS_ASSUME_NONNULL_BEGIN
/// 本类只管理用户数据的存取，数据存储在NSUserDefault里
@interface DDUserInfo : NSObject

@property(nonatomic,strong)NSString *postDraftURLStr;//用户发帖的文本草稿本地存储地址
@property(nonatomic,strong)DDUserModel *userModel;

+(instancetype)sharedInstance;
//鉴别是否登录的标准：userIdKey值对应的token是否为空
-(BOOL)isLogin;

@end

NS_ASSUME_NONNULL_END
