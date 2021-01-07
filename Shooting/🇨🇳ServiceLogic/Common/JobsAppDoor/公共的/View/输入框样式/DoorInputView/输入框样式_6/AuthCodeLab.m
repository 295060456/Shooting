//
//  AuthCodeLab.m
//  DouDong-II
//
//  Created by Jobs on 2020/12/20.
//

#import "AuthCodeLab.h"

@interface AuthCodeLab ()

@end

@implementation AuthCodeLab

- (instancetype)init{
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        [self requestAuthCode];
    }return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    [self requestAuthCode];
}
// 获取验证码
-(void)requestAuthCode{
    NSLog(@"当前是否有网：%d 状态：%ld",[ZBRequestManager isNetworkReachable],[ZBRequestManager networkReachability]);
    [DataManager sharedInstance].tag = ReuseIdentifier;
    /**
     公共配置
     插件机制
     证书设置
     */
    [RequestTool setupPublicParameters];
    @weakify(self)
    [NetworkingAPI requestApi:NSObject.randCodeGET.funcName
                   parameters:nil
                 successBlock:^(id data) {
        @strongify(self)
        NSLog(@"获取验证码成功");
        if ([data isKindOfClass:NSDictionary.class]) {
            NSDictionary *dataDic = (NSDictionary *)data;
            if ([dataDic[HTTPServiceResponseCodeKey] intValue] == HTTPResponseCodeSuccess) {
                self.authCodeModel.captchaKey = dataDic[@"data"][@"captchaKey"];
                self.authCodeModel.imgCode = dataDic[@"data"][@"imgCode"];
                self.text = self.authCodeModel.imgCode;
            }
        }
    }];
}
#pragma mark —— lazyLoad
-(AuthCodeModel *)authCodeModel{
    if (!_authCodeModel) {
        _authCodeModel = AuthCodeModel.new;
    }return _authCodeModel;
}

@end

@implementation AuthCodeModel
 
@end



