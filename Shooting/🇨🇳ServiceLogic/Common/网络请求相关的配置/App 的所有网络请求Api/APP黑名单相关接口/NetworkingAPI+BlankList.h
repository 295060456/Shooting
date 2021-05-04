//
//  NetworkingAPI+BlankList.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "NetworkingAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkingAPI (BlankList)

#pragma mark —— APP黑名单相关接口
/// 添加
+(void)blackListAddPOST:(id)parameters
       withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 删除
+(void)blackListDeleteGET:(id)parameters
         withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 黑名单列表
+(void)blackListGET:(id)parameters
   withsuccessBlock:(MKDataBlock _Nullable)successBlock;

@end

NS_ASSUME_NONNULL_END
