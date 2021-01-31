//
//  NetworkingAPI+VideoApi.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "NetworkingAPI.h"
#import "DDSortVideoListModel.h"
#import "VideoTagModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkingAPI (VideoApi)

#pragma mark —— APP视频相关接口
/// 删除自己发布的视频
+(void)delAppVideoPOST:(id)parameters
      withsuccessBlock:(MKDataBlock)successBlock;
/// 标签列表
+(void)labelListGET:(id)parameters
   withsuccessBlock:(MKDataBlock)successBlock;

/// 标签列表
+(void)sortVideolabelList:(nullable void (^)(NSMutableArray<VideoTagModel *> *result))success
                  failure:(nullable void (^)(NSError *))failure;



/// 视频列表(关注、点赞)
+(void)loadVideosPOST:(id)parameters
              success:(nullable void (^)(DDSortVideoApiModel *result))success
              failure:(nullable void (^)(NSError *))failure;
/// 视频点赞or取消
+(void)praiseVideoPOST:(id)parameters
      withsuccessBlock:(MKDataBlock)successBlock;
/// 生成上传链接
+(void)presignedUploadUrlPOST:(id)parameters
             withsuccessBlock:(MKDataBlock)successBlock;

/// 推荐的视频列表
+(void)recommendVideosPOST:(id)parameters
                   success:(nullable void (^)(DDSortVideoApiModel *result))success
                   failure:(nullable void (^)(NSError *))failure;
/// 搜索视频
+(void)searchPOST:(id)parameters
 withsuccessBlock:(MKDataBlock)successBlock;
/// 上传视频
+(void)uploadVideoPOST:(id)parameters
      withsuccessBlock:(MKDataBlock)successBlock;

@end

NS_ASSUME_NONNULL_END
