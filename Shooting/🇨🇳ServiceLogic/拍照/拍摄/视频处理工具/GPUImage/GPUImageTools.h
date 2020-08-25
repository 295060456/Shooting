//
//  GPUImageTools.h
//  Shooting
//
//  Created by Jobs on 2020/8/24.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKGPUImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPUImageTools : NSObject

@property(nonatomic,assign)CGSize videoSize;
@property(nonatomic,strong)MKGPUImageView *GPUImageView;//实际上点击的是它，所以点击事件在 myGPUImageView 的回调里面
///_myGPUImageView是点击事件
-(void)actionVedioToolsClickBlock:(MKDataBlock)actionVedioToolsClickBlock;
///视频合并处理结束
-(void)vedioToolsSessionStatusCompletedBlock:(MKDataBlock)vedioToolsSessionStatusCompletedBlock;

+(GPUImageTools *)sharedInstance;

#pragma mark ——实况视频
-(void)LIVE;
#pragma mark —— 开始录制
-(void)vedioShoottingOn;
#pragma mark —— 结束录制
-(void)vedioShoottingEnd;
#pragma mark —— 暂停录制
-(void)vedioShoottingSuspend;
#pragma mark —— 继续录制
-(void)vedioShoottingContinue;
#pragma mark —— 取消录制
-(void)vedioShoottingOff;
#pragma mark —— 翻转摄像头
-(void)overturnCamera;
///视频合并
-(void)mergeAndExportVideos:(NSArray *)videosPathArray
                withOutPath:(NSString *)outpath;


@end

NS_ASSUME_NONNULL_END
