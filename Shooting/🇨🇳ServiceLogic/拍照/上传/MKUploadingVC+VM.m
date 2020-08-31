//
//  MKUploadingVC+VM.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/10.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKUploadingVC+VM.h"

@implementation MKUploadingVC (VM)
/*
 视频大小（单位B，非必传） videoSize
 视频文案（非必传） videoArticle
 视频地址（必传）file
 视频标签(可多选，标签id，以逗号分隔)（非必传） ids
 */
- (void)videosUploadNetworkingWithData:(NSData *)data
                          videoArticle:(NSString *)videoArticle
                              urlAsset:(AVURLAsset *)urlAsset{
    
    self.reqSignal = [[FMARCNetwork sharedInstance] uploadViedoNetworkPath:@""
                                                                    params:@{
                                                                        @"videoSize":@(data.length),
                                                                        @"videoArticle":videoArticle,
                                                                        @"videoTime":@([GPUImageTools getVedioDuringTimeWithUrlAsset:urlAsset])//获取视频文件的总时长
                                                                    }
                                                                 fileDatas:@[data]
                                                                   nameArr:@[@"file"]
                                                                  mimeType:@"mp4"];
    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        @strongify(self)
        NSLog(@"%@",response.reqResult);
        if ([response.reqResult isKindOfClass:NSDictionary.class]) {
            NSDictionary *dic = (NSDictionary *)response.reqResult;
            if ([dic[@"code"] intValue] == 200) {
                [MBProgressHUD wj_showPlainText:@"发布成功" view:getMainWindow()];
                [self afterRelease];
                if (self.MKUploadingBlock) {//为什么不执行？？？
                    self.MKUploadingBlock(@1);
                }
            }else{
                [MBProgressHUD wj_showPlainText:@"服务器异常" view:getMainWindow()];
            }
        }
    }];
}

@end
