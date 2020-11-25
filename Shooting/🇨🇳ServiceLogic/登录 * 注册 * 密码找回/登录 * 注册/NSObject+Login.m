//
//  NSObject+Login.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/9/12.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "NSObject+Login.h"
#import "ShootingAppDelegate.h"

@implementation NSObject (Login)

#pragma mark —— 登录模块 在适当的时候调用
+(void)Login{
    TabbarVC *tabBarVC = ShootingAppDelegate.sharedInstance.tabBarVC;
    @weakify(tabBarVC)
    [DoorVC ComingFromVC:weak_tabBarVC
             comingStyle:ComingStyle_PUSH
       presentationStyle:UIModalPresentationFullScreen
           requestParams:nil
                 success:^(id data) {}
                animated:YES];
}
///权限校验
+(void)checkAuthorityWithType:(MKLoginAuthorityType)type :(MKDataBlock)checkRes{
    ///
    NSDictionary *easyDict = @{
        @"roleType":[NSNumber numberWithInteger:type]//权限类型: 0、评论回复；1、抖币转余额；2、提现；3、上传
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
///随机生成4位随机数
+(void)getAuthCode_networking:(MKDataBlock)authCodeBlock{
    ///
    NSDictionary *easyDict = @{};
    ///
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_GET
                                                           path:@""
                                                     parameters:easyDict];
    RACSignal *reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            NSLog(@"%@",response.reqResult);
            if (authCodeBlock) {
                authCodeBlock(response.reqResult);
            }
        }
    }];
}

@end
