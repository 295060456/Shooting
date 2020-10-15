//
//  DoorVC+VM.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/9/12.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "DoorVC+VM.h"

@implementation DoorVC (VM)

-(void)clearTF{//不能写在弹框里面否则会崩  performSelector、withObject不能写在分类里面
    DoorInputViewStyle_3 *用户名 = (DoorInputViewStyle_3 *)self.loginContentView.inputViewMutArr[0];
    DoorInputViewStyle_3 *密码 = (DoorInputViewStyle_3 *)self.loginContentView.inputViewMutArr[1];
    用户名.tf.text = @"";
    密码.tf.text = @"";
}
///登录
-(void)login_networkingWithUserName:(NSString *)account
                           passWord:(NSString *)password
                         originType:(originType)originType{

//    NSDictionary *easyDict = @{
//        @"account":account,//账号
//        @"password":password,//密码
//        @"originType":@(originType)
//    };
//    ///
//    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
//                                                           path:@""
//                                                     parameters:easyDict];
//    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
//    @weakify(self)
//    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
//        @strongify(self)
//        if (response.isSuccess) {
//            NSLog(@"%@",response.reqResult);
//            if ([response.reqResult isKindOfClass:NSDictionary.class]) {
//                //登录成功走以下代码
//                //登陆成功以后记住账号和密码
//                [self.loginContentView storeAcc_Code];
//                [self backBtnClickEvent:nil];
//            }else if ([response.reqResult isKindOfClass:NSString.class]){
//                CustomSYSUITabBarController *tbvc = [SceneDelegate sharedInstance].customSYSUITabBarController;
//                [NSObject showSYSAlertViewTitle:response.reqResult
//                                        message:@"请重新登录"
//                                isSeparateStyle:NO
//                                    btnTitleArr:@[@"好的"]
//                                 alertBtnAction:@[@""]
//                                       targetVC:tbvc
//                                   alertVCBlock:^(id data) {
//                    //DIY
//                }];
//                [self clearTF];
//            }else{}
//        }
//    }];
}
///注册
-(void)register_networkingWithAccount:(NSString *)account
                             password:(NSString *)password
                      confirmPassword:(NSString *)confirmPassword
                           captchaKey:(NSString *)captchaKey
                              imgCode:(NSString *)imgCode
                           originType:(originType)originType{
//    ///
//    NSDictionary *easyDict = @{
//        @"account":account,//账号
//        @"password":password,//密码
//        @"confirmPassword":confirmPassword,
//        @"captchaKey":captchaKey,
//        @"imgCode":imgCode,
//        @"originType":@(originType)
//    };
//    ///
//    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
//                                                           path:@""
//                                                     parameters:easyDict];
//    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
//    @weakify(self)
//    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
//        @strongify(self)
//        if (response.isSuccess) {
//            NSLog(@"%@",response.reqResult);
//            //注册成功即登录
//            if ([response.reqResult isKindOfClass:NSDictionary.class]) {
//                //登录成功走以下代码
//                [WHToast showErrorWithMessage:@"登录成功"
//                                     duration:2
//                                finishHandler:^{
//                  
//                }];
//                self.loginContentView = nil;
//                [self backBtnClickEvent:nil];
//            }else if ([response.reqResult isKindOfClass:NSString.class]){
//                CustomSYSUITabBarController *tbvc = [SceneDelegate sharedInstance].customSYSUITabBarController;
//                [NSObject showSYSAlertViewTitle:response.reqResult
//                                        message:@"请重新登录"
//                                isSeparateStyle:NO
//                                    btnTitleArr:@[@"好的"]
//                                 alertBtnAction:@[@""]
//                                       targetVC:tbvc
//                                   alertVCBlock:^(id data) {
//                    //DIY
//                }];
//                [self clearTF];
//            }else{}
//        }
//    }];
}

@end
