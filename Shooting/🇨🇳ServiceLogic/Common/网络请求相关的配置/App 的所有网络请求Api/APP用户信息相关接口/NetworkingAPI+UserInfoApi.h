//
//  NetworkingAPI+UserInfoApi.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "NetworkingAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkingAPI (UserInfoApi)

#pragma mark —— APP用户信息相关接口
/// 绑定手机号
+(void)bindPhonePOST:(id)parameters
    withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 校验是否有权限
+(void)checkHadRoleGET:(id)parameters
      withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 进行签到
+(void)doSignPOST:(id)parameters
 withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 获取我的详情
+(void)myUserInfoGET:(id)parameters
    withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 滚动数据
+(void)rollDateGET:(id)parameters
  withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 查询用户信息
+(void)selectIdCardGET:(id)parameters
      withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 我的签到列表
+(void)signListGET:(id)parameters
  withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 编辑个人资料
+(void)userInfoUpdatePOST:(id)parameters
         withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 绑定支付宝
+(void)updateAccountInfoPOST:(id)parameters
            withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 邀请好友
+(void)userInfoUpdateCodePOST:(id)parameters
             withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 上传头像
+(void)uploadImagePOST:(id)parameters
      withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 获取用户详情
+(void)userInfoGET:(id)parameters
  withsuccessBlock:(MKDataBlock _Nullable)successBlock;

@end

NS_ASSUME_NONNULL_END
