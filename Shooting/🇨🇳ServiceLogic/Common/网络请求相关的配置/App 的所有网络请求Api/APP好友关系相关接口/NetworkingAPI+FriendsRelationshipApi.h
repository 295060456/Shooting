//
//  NetworkingAPI+FriendsRelationshipApi.h
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

@interface NetworkingAPI (FriendsRelationshipApi)

#pragma mark —— APP好友关系相关接口
/// 手动执行奖励记录
+(void)addAwardGET:(id)parameters
  withsuccessBlock:(MKDataBlock)successBlock;
/// 手动执行奖励记录
+(void)addAwardInfoGET:(id)parameters
      withsuccessBlock:(MKDataBlock)successBlock;
/// 获取活跃用户
+(void)awardListGET:(id)parameters
   withsuccessBlock:(MKDataBlock)successBlock;
/// 最新四个好友
+(void)fourListGET:(id)parameters
  withsuccessBlock:(MKDataBlock)successBlock;
/// selectUrl
+(void)friendUrlselectUrlGET:(id)parameters
            withsuccessBlock:(MKDataBlock)successBlock;
/// 好友列表
+(void)userFriendListGET:(id)parameters
        withsuccessBlock:(MKDataBlock)successBlock;
/// 统计我的收益
+(void)myInComeGET:(id)parameters
  withsuccessBlock:(MKDataBlock)successBlock;
///面对面邀请保存好友手机号码 
+(void)savePhonePOST:(id)parameters
    withsuccessBlock:(MKDataBlock)successBlock;
@end

NS_ASSUME_NONNULL_END
