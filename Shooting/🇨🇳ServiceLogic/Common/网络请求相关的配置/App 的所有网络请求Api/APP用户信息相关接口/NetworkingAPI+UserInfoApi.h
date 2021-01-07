//
//  NetworkingAPI+UserInfoApi.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "NetworkingAPI.h"
/*
 * APP端接口文档
 * http://172.24.135.53:8011/swagger-ui.html#/APP%E7%94%A8%E6%88%B7%E4%BF%A1%E6%81%AF%E7%9B%B8%E5%85%B3%E6%8E%A5%E5%8F%A3
 
 开发环境：
 管理后台：http://172.24.135.55/
 app-api：http://172.24.135.55/api/
 h5：http://172.24.135.55/taskpage/

 测试环境(数据已初始化)：
 管理后台：http://172.24.135.54/dist/
 app-api：http://172.24.135.54/api/
 h5：http://172.24.135.54/taskpage/
 
 抖动生产环境
 web-admin：http://www.xiuwa.top/web/beBQJvUpWl
 H5：https://www.xiuwa.top/h5/
 API：https://www.xiuwa.top/api/
 
 抖动备用域名：
 www.vdutbr.cn
 www.peprh.cn
 www.msahe.cn
 
 */
NS_ASSUME_NONNULL_BEGIN

@interface NetworkingAPI (UserInfoApi)

#pragma mark —— APP用户信息相关接口
/// 绑定手机号
+(void)bindPhonePOST:(id)parameters
    withsuccessBlock:(MKDataBlock)successBlock;
/// 校验是否有权限
+(void)checkHadRoleGET:(id)parameters
      withsuccessBlock:(MKDataBlock)successBlock;
/// 进行签到
+(void)doSignPOST:(id)parameters
 withsuccessBlock:(MKDataBlock)successBlock;
/// 获取我的详情
+(void)myUserInfoGET:(id)parameters
    withsuccessBlock:(MKDataBlock)successBlock;
/// 滚动数据
+(void)rollDateGET:(id)parameters
  withsuccessBlock:(MKDataBlock)successBlock;
/// 查询用户信息
+(void)selectIdCardGET:(id)parameters
      withsuccessBlock:(MKDataBlock)successBlock;
/// 我的签到列表
+(void)signListGET:(id)parameters
  withsuccessBlock:(MKDataBlock)successBlock;
/// 编辑个人资料
+(void)userInfoUpdatePOST:(id)parameters
         withsuccessBlock:(MKDataBlock)successBlock;
/// 绑定支付宝
+(void)updateAccountInfoPOST:(id)parameters
            withsuccessBlock:(MKDataBlock)successBlock;
/// 邀请好友
+(void)userInfoUpdateCodePOST:(id)parameters
             withsuccessBlock:(MKDataBlock)successBlock;
/// 上传头像
+(void)uploadImagePOST:(id)parameters
      withsuccessBlock:(MKDataBlock)successBlock;
/// 获取用户详情
+(void)userInfoGET:(id)parameters
  withsuccessBlock:(MKDataBlock)successBlock;

@end

NS_ASSUME_NONNULL_END
