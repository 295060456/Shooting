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
#pragma mark —— 普通的网络请求
/// 【只有Body参数、不需要错误回调】
+(void)requestApi:(NSString *_Nonnull)requestApi
       parameters:(id _Nullable)parameters
     successBlock:(MKDataBlock)successBlock;
///【只有Body参数、需要错误回调的】
+(void)requestApi:(NSString *_Nonnull)requestApi
       parameters:(id _Nullable)parameters
     successBlock:(MKDataBlock)successBlock
     failureBlock:(MKDataBlock)failureBlock;
#pragma mark —— 特殊的上传文件的网络请求
/// 上传【图片】文件的网络请求
+(void)requestApi:(NSString *_Nonnull)requestApi
uploadImagesParamArr:(NSArray *)uploadImagesParamArr
     successBlock:(MKDataBlock)successBlock
     failureBlock:(MKDataBlock)failureBlock;
/// 上传【视频】文件的网络请求
+(void)requestApi:(NSString *_Nonnull)requestApi
uploadVideosParamArr:(NSArray *)uploadVideosParamArr
     successBlock:(MKDataBlock)successBlock
     failureBlock:(MKDataBlock)failureBlock;
#pragma mark —— 其他的一些调用方式，和上面等价
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

+(void)upload:(NSString *)path
   parameters:(nullable id)parameters
  uploadDatas:(NSMutableArray<ZBUploadData *> *)uploadDatas
requestSerializer:(ZBRequestSerializerType)requestSerializerType
    headers:(nullable NSDictionary <NSString *, NSString *> *)headers
   progress:(nullable void (^)(NSProgress * _Nonnull))progress
    success:(nullable void (^)(DDResponseModel *))success
      failure:(nullable void (^)(NSError *))failure;

@end

NS_ASSUME_NONNULL_END
