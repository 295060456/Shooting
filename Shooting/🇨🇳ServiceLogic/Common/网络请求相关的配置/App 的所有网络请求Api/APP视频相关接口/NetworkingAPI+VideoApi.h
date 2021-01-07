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
/*
 * APP端接口文档
 * http://172.24.135.53:8011/swagger-ui.html#/APP%E7%94%A8%E6%88%B7%E4%BF%A1%E6%81%AF%E7%9B%B8%E5%85%B3%E6%8E%A5%E5%8F%A3
 
 开发环境：
 管理后台：http://172.24.135.55/
 app-api：http://172.24.135.55/api/
 h5：http://172.24.135.55/taskpage/

 测试环境(数据已初始化)：
 管理后台：http://172.24.135.54/dist/
 app-api：http://172.24.135.54/api/
 h5：http://172.24.135.54/taskpage/
 
 抖动生产环境
 web-admin：http://www.xiuwa.top/web/beBQJvUpWl
 H5：https://www.xiuwa.top/h5/
 API：https://www.xiuwa.top/api/
 
 抖动备用域名：
 www.vdutbr.cn
 www.peprh.cn
 www.msahe.cn
 
 */
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
