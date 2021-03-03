//
//  DDSortVideoListModel.h
//  DouDong-II
//
//  Created by xxx on 2020/12/23.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface DDSortVideoListModel : NSObject

/// 作者
@property (nonatomic, strong) NSString *author;
/// 作者ID
@property (nonatomic, strong) NSString *authorId;
/// 评论数
@property (nonatomic, assign) NSInteger commentNum;
/// 头像
@property (nonatomic, strong) NSString *headImage;

/// 播放数
@property (nonatomic, assign) NSInteger playNum;

/// 点赞数
@property (nonatomic, assign) NSInteger praiseNum;

/// 发布时间
@property (nonatomic, strong) NSString *publishTime;

/// 视频id
@property (nonatomic, strong) NSString *videoId;

/// 视频地址
@property (nonatomic, strong) NSString *videoIdcUrl;

/// 封面图片
@property (nonatomic, strong) NSString *videoImg;

///视频大小
@property (nonatomic, strong) NSString *videoSize;

/// 视频时间
@property (nonatomic, strong) NSString *videoTime;

/// 视频标题
@property (nonatomic, strong) NSString *videoTitle;


@property (nonatomic, assign) BOOL isPraise;


@property (nonatomic, assign) BOOL isAttention;

/// 自定义类型 0 视频  1 广告
@property (nonatomic, strong) NSString *mkCustomtype;
// 自定义类型 0 跳转至直播视频  1 跳转至广告
@property (nonatomic, strong) NSString *nextLinkUrl;
// 1 用户自己 ｜  0 其他人
@property (nonatomic, assign) BOOL areSelf;
//0待审核 1审核通过 2审核不通过
@property (nonatomic, strong) NSString *videoStatus;

@property (nonatomic,assign) BOOL isVip;

@property (nonatomic,strong) NSString  *labelIds;
@property (nonatomic,strong) NSString  *labelNames;


@end

@interface DDSortVideoApiModel : BaseModel

@property(nonatomic,strong) NSMutableArray<DDSortVideoListModel *> *list;

@end


NS_ASSUME_NONNULL_END
