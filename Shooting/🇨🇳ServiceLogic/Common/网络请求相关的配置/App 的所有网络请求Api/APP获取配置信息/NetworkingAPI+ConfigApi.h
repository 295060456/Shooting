//
//  NetworkingAPI+ConfigApi.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "NetworkingAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkingAPI (ConfigApi)

#pragma mark —— APP获取配置信息
/// app启动参数
+(void)refreshGET:(id)parameters
 withsuccessBlock:(MKDataBlock)successBlock;

@end

NS_ASSUME_NONNULL_END
