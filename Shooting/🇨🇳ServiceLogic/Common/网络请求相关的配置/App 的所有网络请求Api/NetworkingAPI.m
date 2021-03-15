//
//  NetworkingAPI.m
//  DouYin
//
//  Created by Jobs on 2020/9/24.
//

#import "NetworkingAPI.h"
#import "NetworkingAPI+StatisticsApi.h"//数据统计相关接口
#import "NetworkingAPI+LoginApi.h"//APP登录信息相关接口
#import "NetworkingAPI+AdsApi.h"//APP广告相关接口
#import "NetworkingAPI+FriendsRelationshipApi.h"//APP好友关系相关接口
#import "NetworkingAPI+BlankList.h"//APP黑名单相关接口
#import "NetworkingAPI+ConfigApi.h"//APP获取配置信息
#import "NetworkingAPI+EarnApi.h"//APP看视频获得金币奖励
#import "NetworkingAPI+CommentApi.h"//APP评论相关接口
#import "NetworkingAPI+WalletApi.h"//APP钱包相关接口
#import "NetworkingAPI+VideoApi.h"//APP视频相关接口
#import "NetworkingAPI+MsgApi.h"//App消息相关接口
#import "NetworkingAPI+MsgStateApi.h"//App消息状态相关接口
#import "NetworkingAPI+BankCardApi.h"//APP银行卡相关接口
#import "NetworkingAPI+UserFansApi.h"//APP用户粉丝相关接口
#import "NetworkingAPI+UserInfoApi.h"//APP用户信息相关接口
/*
 * 只定义successBlock处理我们想要的最正确的答案,并向外抛出
 * 错误在内部处理不向外抛出
 */
@implementation NetworkingAPI
#pragma mark —— 普通的网络请求
/// 【只有Body参数、不需要错误回调】
+(void)requestApi:(NSString *_Nonnull)requestApi
       parameters:(id _Nullable)parameters
     successBlock:(MKDataBlock)successBlock{
    
    NSLog(@"接口名：%@，请求参数打印 %@",requestApi,parameters);
    
    {
        NSMutableArray *paramMutArr = NSMutableArray.array;
        [paramMutArr addObject:parameters];
        
        if (successBlock) {
            [paramMutArr addObject:successBlock];
        }

        NSString *funcName = [requestApi stringByAppendingString:@":successBlock:"];
        [NSObject methodName:funcName
                      target:self
                 paramarrays:paramMutArr];
    }
}
///【只有Body参数、需要错误回调的】
+(void)requestApi:(NSString *_Nonnull)requestApi
       parameters:(id _Nullable)parameters
     successBlock:(MKDataBlock)successBlock
     failureBlock:(MKDataBlock)failureBlock{
    
    NSLog(@"接口名：%@，请求参数打印 %@",requestApi,parameters);
    
    {
        NSMutableArray *paramMutArr = NSMutableArray.array;
        [paramMutArr addObject:parameters];
        
        if (successBlock) {
            [paramMutArr addObject:successBlock];
        }
        
        if (failureBlock) {
            [paramMutArr addObject:failureBlock];
        }

        NSString *funcName = [requestApi stringByAppendingString:@":successBlock:failureBlock:"];
        [NSObject methodName:funcName
                      target:self
                 paramarrays:paramMutArr];
    }
}
#pragma mark —— 特殊的上传文件的网络请求
/// 上传【图片】文件的网络请求
+(void)requestApi:(NSString *_Nonnull)requestApi
uploadImagesParamArr:(NSArray *)uploadImagesParamArr
     successBlock:(MKDataBlock)successBlock
     failureBlock:(MKDataBlock)failureBlock{

    NSMutableArray *paramMutArr = [NSMutableArray arrayWithArray:uploadImagesParamArr];
    
    if (successBlock) {
        [paramMutArr addObject:successBlock];
    }
    
    if (failureBlock) {
        [paramMutArr addObject:failureBlock];
    }
    
    NSString *funcName = [requestApi stringByAppendingString:@":uploadImageDatas:successBlock:failureBlock:"];
    [NSObject methodName:funcName
                  target:self
             paramarrays:paramMutArr];
}
/// 上传【视频】文件的网络请求
+(void)requestApi:(NSString *_Nonnull)requestApi
uploadVideosParamArr:(NSArray *)uploadVideosParamArr
     successBlock:(MKDataBlock)successBlock
     failureBlock:(MKDataBlock)failureBlock{

    NSMutableArray *paramMutArr = [NSMutableArray arrayWithArray:uploadVideosParamArr];
    
    if (successBlock) {
        [paramMutArr addObject:successBlock];
    }
    
    if (failureBlock) {
        [paramMutArr addObject:failureBlock];
    }
    
    NSString *funcName = [requestApi stringByAppendingString:@":uploadVideo:successBlock:failureBlock:"];
    [NSObject methodName:funcName
                  target:self
             paramarrays:paramMutArr];
}
#pragma mark —— 其他的一些调用方式，和上面等价
+(void)request:(NSString *)path
        method:(ZBMethodType)type
    parameters:(nullable id)parameters
   uploadDatas:(NSMutableArray<ZBUploadData *> *)uploadDatas
requestSerializer:(ZBRequestSerializerType)requestSerializerType
       headers:(nullable NSDictionary <NSString *, NSString *> *)headers
      progress:(nullable void (^)(NSProgress * _Nonnull))progress
       success:(nullable void (^)(DDResponseModel *))success
       failure:(nullable void (^)(NSError *))failure {
    [ZBRequestManager requestWithConfig:^(ZBURLRequest * _Nullable request) {
        request.server = NSObject.BaseUrl;
        request.url = [request.server stringByAppendingString:path];
        NSLog(@"request.URLString = %@",request.url);
        request.methodType = type;
        request.apiType = ZBRequestTypeRefresh;//（默认为ZBRequestTypeRefresh 不读取缓存，不存储缓存）
        request.parameters = parameters;//与公共配置 Parameters 兼容
        request.headers = headers;//与公共配置 Headers 兼容
        request.retryCount = 1;//请求失败 单次请求 重新连接次数 优先级大于 全局设置，不影响其他请求设置
        request.timeoutInterval = 120;//默认30 //优先级 高于 公共配置,不影响其他请求设置
        request.requestSerializer = requestSerializerType;
        request.uploadDatas = uploadDatas;
        if (![NSString isNullString:[DataManager sharedInstance].tag]) {
            request.userInfo = @{@"info":[DataManager sharedInstance].tag};//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        };//与公共配置 UserInfo 不兼容 优先级大于 公共配置
    }progress:^(NSProgress * _Nullable progress){
        NSLog(@"进度 = %f",progress.fractionCompleted * 100);
    }success:^(id  _Nullable responseObject,
               ZBURLRequest * _Nullable request){
        NSLog(@"responseObject = %@",responseObject);
        DDResponseModel *model = [DDResponseModel mj_objectWithKeyValues:responseObject];
        if(model.code == 200) {
            if(success) {
                success(model);
            }
        } else {
            if(failure) {
                NSError *error = [NSError errorWithDomain:NSNetServicesErrorDomain
                                                     code:model.code
                                                 userInfo:@{@"msg":model.msg}];
                failure(error);
            }
        }
    } failure:failure finished:^(id  _Nullable responseObject,
                NSError * _Nullable error,
                ZBURLRequest * _Nullable request) {
        NSLog(@"请求完成 userInfo:%@",request.userInfo);
    }];
}

+(void)POST:(NSString *)path
 parameters:(nullable id)parameters
requestSerializer:(ZBRequestSerializerType)requestSerializerType
    headers:(nullable NSDictionary <NSString *, NSString *> *)headers
   progress:(nullable void (^)(NSProgress * _Nonnull))progress
    success:(nullable void (^)(DDResponseModel *))success
    failure:(nullable void (^)(NSError *))failure {
    [self request:path
           method:ZBMethodTypePOST
       parameters:parameters
      uploadDatas: nil
requestSerializer:requestSerializerType
          headers:headers
         progress:progress
          success:success
          failure:failure];
}

+(void)GET:(NSString *)path
 parameters:(nullable id)parameters
requestSerializer:(ZBRequestSerializerType)requestSerializerType
    headers:(nullable NSDictionary <NSString *, NSString *> *)headers
   progress:(nullable void (^)(NSProgress * _Nonnull))progress
    success:(nullable void (^)(DDResponseModel *))success
    failure:(nullable void (^)(NSError *))failure {
    [self request:path
           method:ZBMethodTypeGET
       parameters:parameters
      uploadDatas:nil
requestSerializer:requestSerializerType
          headers:headers
         progress:progress
          success:success
          failure:failure];
}

+(void)upload:(NSString *)path
   parameters:(nullable id)parameters
  uploadDatas:(NSMutableArray<ZBUploadData *> *)uploadDatas
requestSerializer:(ZBRequestSerializerType)requestSerializerType
      headers:(nullable NSDictionary <NSString *, NSString *> *)headers
     progress:(nullable void (^)(NSProgress * _Nonnull))progress
      success:(nullable void (^)(DDResponseModel *))success
      failure:(nullable void (^)(NSError *))failure {
    [self request:path
           method:ZBMethodTypeUpload
       parameters:parameters
      uploadDatas:uploadDatas
requestSerializer:requestSerializerType
          headers:headers
         progress:progress
          success:success
          failure:failure];
}

@end
