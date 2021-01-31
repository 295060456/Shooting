//
//  NetworkingAPI+UserFansApi.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "NetworkingAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkingAPI (UserFansApi)

#pragma mark —— APP用户粉丝相关接口
/// 用户粉丝列表
+(void)userFansListGET:(id)parameters
      withsuccessBlock:(MKDataBlock)successBlock;

@end

NS_ASSUME_NONNULL_END
