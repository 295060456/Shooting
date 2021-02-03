//
//  NetworkingAPI.h
//  DouYin
//
//  Created by Jobs on 2020/9/24.
//

#import <Foundation/Foundation.h>
#import "RequestTool.h"
#import "ZBNetworking.h"
#import "DDResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkingAPI : NSObject
// 不需要错误回调的
+(void)requestApi:(NSString *_Nonnull)requestApi
       parameters:(id _Nullable)parameters
     successBlock:(MKDataBlock)successBlock;
// 需要错误回调的
+(void)requestApi:(NSString *_Nonnull)requestApi
       parameters:(id _Nullable)parameters
     successBlock:(MKDataBlock)successBlock
     failureBlock:(MKDataBlock)failureBlock;

+(void)POST:(NSString *)path
 parameters:(nullable id)parameters
requestSerializer:(ZBRequestSerializerType)requestSerializerType
    headers:(nullable NSDictionary <NSString *, NSString *> *)headers
   progress:(nullable void (^)(NSProgress * _Nonnull))progress
    success:(nullable void (^)(DDResponseModel *))success
    failure:(nullable void (^)(NSError *))failure;

+(void)GET:(NSString *)path
 parameters:(nullable id)parameters
requestSerializer:(ZBRequestSerializerType)requestSerializerType
    headers:(nullable NSDictionary <NSString *, NSString *> *)headers
   progress:(nullable void (^)(NSProgress * _Nonnull))progress
    success:(nullable void (^)(DDResponseModel *))success
   failure:(nullable void (^)(NSError *))failure;

@end

NS_ASSUME_NONNULL_END
