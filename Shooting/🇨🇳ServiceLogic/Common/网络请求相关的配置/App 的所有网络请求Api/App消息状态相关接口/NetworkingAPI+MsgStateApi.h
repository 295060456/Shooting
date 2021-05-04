//
//  NetworkingAPI+MsgStateApi.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "NetworkingAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkingAPI (MsgStateApi)

#pragma mark —— App消息状态相关接口
/// 添加已读消息 POST
+(void)messageStatusAddPOST:(id)parameters
           withsuccessBlock:(MKDataBlock _Nullable)successBlock;

@end

NS_ASSUME_NONNULL_END
