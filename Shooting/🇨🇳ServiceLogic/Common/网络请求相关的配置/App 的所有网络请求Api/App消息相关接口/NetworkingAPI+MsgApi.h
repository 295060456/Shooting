//
//  NetworkingAPI+MsgApi.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "NetworkingAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkingAPI (MsgApi)

#pragma mark —— App消息相关接口
/// 获取用户粉丝详情
+(void)fansInfoGET:(id)parameters
  withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 消息一级列表
+(void)messageFirstClassListGET:(id)parameters
               withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 获取系统消息详情视频列表
+(void)messageInfoGET:(id)parameters
     withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 消息二级级列表
+(void)messageSecondClassListGET:(id)parameters
                withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 公告列表
+(void)noticeListGET:(id)parameters
       withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 消息开关列表
+(void)turnOffListGET:(id)parameters
     withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 修改消息开关
+(void)updateOffPOST:(id)parameters
    withsuccessBlock:(MKDataBlock _Nullable)successBlock;

@end

NS_ASSUME_NONNULL_END
