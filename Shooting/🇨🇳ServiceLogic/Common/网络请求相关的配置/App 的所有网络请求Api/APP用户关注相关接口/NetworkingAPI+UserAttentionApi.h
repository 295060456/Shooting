//
//  NetworkingAPI+UserAttentionApi.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "NetworkingAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkingAPI (UserAttentionApi)

#pragma mark —— APP用户关注相关接口
/// 添加
+(void)userFocusAddPOST:(id)parameters
       withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 删除
+(void)userFocusDeleteGET:(id)parameters
         withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 关注用户列表
+(void)userFocusListGET:(id)parameters
       withsuccessBlock:(MKDataBlock _Nullable)successBlock;

@end

NS_ASSUME_NONNULL_END
