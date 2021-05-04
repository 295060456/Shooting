//
//  NetworkingAPI+StatisticsApi.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "NetworkingAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkingAPI (StatisticsApi)

#pragma mark —— 数据统计相关接口
/// 活跃用户
+(void)addActiveUserDataPOST:(id)parameters
            withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 启动次数
+(void)addStartTimePOST:(id)parameters
       withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 使用时长
+(void)addUseTimeDataPOST:(id)parameters
         withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 渠道列表
+(void)channelListGET:(id)parameters
     withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 版本信息
+(void)versionInfoAppGET:(id)parameters
        withsuccessBlock:(MKDataBlock _Nullable)successBlock;

@end

NS_ASSUME_NONNULL_END
