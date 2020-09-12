//
//  NSObject+Login.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/9/12.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "NSObject+Login.h"

@implementation NSObject (Login)

#pragma mark —— 登录模块 在适当的时候调用
+(void)Login{
//    [[MKLoginModel getUsingLKDBHelper] deleteToDB:[MKPublickDataManager sharedPublicDataManage].mkLoginModel];
//    [[MKTools shared] cleanCacheAndCookie];
//    [MKPublickDataManager sharedPublicDataManage].mkLoginModel.token = @"";
    CustomSYSUITabBarController *tbvc = [SceneDelegate sharedInstance].customSYSUITabBarController;
    @weakify(tbvc)
//    [LoginVC ComingFromVC:weak_tbvc
//              comingStyle:ComingStyle_PRESENT
//        presentationStyle:UIModalPresentationFullScreen
//            requestParams:nil
//                  success:^(id data) {}
//                 animated:YES];
    
    [DoorVC ComingFromVC:weak_tbvc
             comingStyle:ComingStyle_PUSH
       presentationStyle:UIModalPresentationFullScreen
           requestParams:nil
                 success:^(id data) {}
                animated:YES];
}
///权限校验
+(void)checkAuthority:(MKDataBlock)checkRes{
    ///
    NSDictionary *easyDict = @{
        @"roleType":[NSNumber numberWithInteger:3]//权限类型: 0、评论回复；1、抖币转余额；2、提现；3、上传
    };//流水类型(0-金币流水，1-余额流水)
    ///
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_GET
                                                           path:@""
                                                     parameters:easyDict];
    RACSignal *reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            NSLog(@"");
            if (checkRes) {
                checkRes(response.reqResult);
            }
        }
    }];
}

@end
