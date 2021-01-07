//
//  NetworkingAPI+MsgApi.h
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

@interface NetworkingAPI (MsgApi)

#pragma mark —— App消息相关接口
/// 获取用户粉丝详情
+(void)fansInfoGET:(id)parameters
  withsuccessBlock:(MKDataBlock)successBlock;
/// 消息一级列表
+(void)messageFirstClassListGET:(id)parameters
               withsuccessBlock:(MKDataBlock)successBlock;
/// 获取系统消息详情视频列表
+(void)messageInfoGET:(id)parameters
     withsuccessBlock:(MKDataBlock)successBlock;
/// 消息二级级列表
+(void)messageSecondClassListGET:(id)parameters
                withsuccessBlock:(MKDataBlock)successBlock;
/// 公告列表
+(void)noticeListGET:(id)parameters
       withsuccessBlock:(MKDataBlock)successBlock;
/// 消息开关列表
+(void)turnOffListGET:(id)parameters
     withsuccessBlock:(MKDataBlock)successBlock;
/// 修改消息开关
+(void)updateOffPOST:(id)parameters
    withsuccessBlock:(MKDataBlock)successBlock;

@end

NS_ASSUME_NONNULL_END
