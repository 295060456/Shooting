//
//  NetworkingAPI+LoginApi.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "NetworkingAPI+LoginApi.h"

@implementation NetworkingAPI (LoginApi)

#pragma mark —— APP登录信息相关接口
/// 找回密码接口-重置密码
+(void)changePasswordPOST:(id)parameters
         withsuccessBlock:(MKDataBlock _Nullable)successBlock{
    NSDictionary *parameterss = @{};
    NSDictionary *headers = @{};
    
    [ZBRequestManager requestWithConfig:^(ZBURLRequest * _Nullable request) {

        request.server = NSObject.BaseUrl;
        request.url = [request.server stringByAppendingString:NSObject.changePasswordPOST.url];
        
        NSLog(@"request.URLString = %@",[request.server stringByAppendingString:request.url]);
        
        request.methodType = ZBMethodTypePOST;//默认为GET
        request.apiType = ZBRequestTypeRefresh;//（默认为ZBRequestTypeRefresh 不读取缓存，不存储缓存）
        request.parameters = parameterss;//与公共配置 Parameters 兼容
        request.headers = headers;//与公共配置 Headers 兼容
        request.retryCount = 1;//请求失败 单次请求 重新连接次数 优先级大于 全局设置，不影响其他请求设置
        request.timeoutInterval = 10;//默认30 //优先级 高于 公共配置,不影响其他请求设置
        if (![NSString isNullString:[DataManager sharedInstance].tag]) {
            request.userInfo = @{@"info":[DataManager sharedInstance].tag};//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        };//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        
        {
//            request.filtrationCacheKey = @[@""];//与公共配置 filtrationCacheKey 兼容
//            request.requestSerializer = ZBJSONRequestSerializer; //单次请求设置 请求格式 默认JSON，优先级大于 公共配置，不影响其他请求设置
//            request.responseSerializer = ZBJSONResponseSerializer; //单次请求设置 响应格式 默认JSON，优先级大于 公共配置,不影响其他请求设置
           
            /**
             多次请求同一个接口 保留第一次或最后一次请求结果 只在请求时有用  读取缓存无效果。默认ZBResponseKeepNone 什么都不做
             使用场景是在 重复点击造成的 多次请求，如发帖，评论，搜索等业务
             */
//            request.keepType=ZBResponseKeepNone;
        }//一些临时的其他的配置
        
    }progress:^(NSProgress * _Nullable progress){
        NSLog(@"进度 = %f",progress.fractionCompleted * 100);
    }success:^(id  _Nullable responseObject,
               ZBURLRequest * _Nullable request){
        if ([responseObject isKindOfClass:NSDictionary.class]) {
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            DDResponseModel *model = [DDResponseModel mj_objectWithKeyValues:dataDic];
            // 公共请求错误直接抛出
            if (model.code != HTTPResponseCodeSuccess) {
                [WHToast toastMsg:model.msg];
            }else{
                if (successBlock) {
                    successBlock(model);
                }
            }
        }else{
            [WHToast toastMsg:[@"异常接口" stringByAppendingString:NSObject.userInfoSelectVideoCountPOST.funcName]];
        }
    }
            successBlock(responseObject);
        }
    }failure:^(NSError * _Nullable error){
        NSLog(@"error = %@",error);
    }finished:^(id  _Nullable responseObject,
                NSError * _Nullable error,
                ZBURLRequest * _Nullable request){
        NSLog(@"请求完成 userInfo:%@",request.userInfo);
    }];
}
/// 找回密码接口-身份验证
+(void)checkIdentityPOST:(id)parameters
        withsuccessBlock:(MKDataBlock _Nullable)successBlock{
    NSDictionary *parameterss = @{};
    NSDictionary *headers = @{};
    
    [ZBRequestManager requestWithConfig:^(ZBURLRequest * _Nullable request) {

        request.server = NSObject.BaseUrl;
        request.url = [request.server stringByAppendingString:NSObject.checkIdentityPOST.url];
        
        NSLog(@"request.URLString = %@",[request.server stringByAppendingString:request.url]);
        
        request.methodType = ZBMethodTypePOST;//默认为GET
        request.apiType = ZBRequestTypeRefresh;//（默认为ZBRequestTypeRefresh 不读取缓存，不存储缓存）
        request.parameters = parameterss;//与公共配置 Parameters 兼容
        request.headers = headers;//与公共配置 Headers 兼容
        request.retryCount = 1;//请求失败 单次请求 重新连接次数 优先级大于 全局设置，不影响其他请求设置
        request.timeoutInterval = 10;//默认30 //优先级 高于 公共配置,不影响其他请求设置
        if (![NSString isNullString:[DataManager sharedInstance].tag]) {
            request.userInfo = @{@"info":[DataManager sharedInstance].tag};//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        };//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        
        {
//            request.filtrationCacheKey = @[@""];//与公共配置 filtrationCacheKey 兼容
//            request.requestSerializer = ZBJSONRequestSerializer; //单次请求设置 请求格式 默认JSON，优先级大于 公共配置，不影响其他请求设置
//            request.responseSerializer = ZBJSONResponseSerializer; //单次请求设置 响应格式 默认JSON，优先级大于 公共配置,不影响其他请求设置
           
            /**
             多次请求同一个接口 保留第一次或最后一次请求结果 只在请求时有用  读取缓存无效果。默认ZBResponseKeepNone 什么都不做
             使用场景是在 重复点击造成的 多次请求，如发帖，评论，搜索等业务
             */
//            request.keepType=ZBResponseKeepNone;
        }//一些临时的其他的配置
        
    }progress:^(NSProgress * _Nullable progress){
        NSLog(@"进度 = %f",progress.fractionCompleted * 100);
    }success:^(id  _Nullable responseObject,
               ZBURLRequest * _Nullable request){
        if ([responseObject isKindOfClass:NSDictionary.class]) {
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            DDResponseModel *model = [DDResponseModel mj_objectWithKeyValues:dataDic];
            // 公共请求错误直接抛出
            if (model.code != HTTPResponseCodeSuccess) {
                [WHToast toastMsg:model.msg];
            }else{
                if (successBlock) {
                    successBlock(model);
                }
            }
        }else{
            [WHToast toastMsg:[@"异常接口" stringByAppendingString:NSObject.userInfoSelectVideoCountPOST.funcName]];
        }
    }
            successBlock(responseObject);
        }
    }failure:^(NSError * _Nullable error){
        NSLog(@"error = %@",error);
    }finished:^(id  _Nullable responseObject,
                NSError * _Nullable error,
                ZBURLRequest * _Nullable request){
        NSLog(@"请求完成 userInfo:%@",request.userInfo);
    }];
}
/// 登录
+(void)appLoginPOST:(id)parameters
   withsuccessBlock:(MKDataBlock _Nullable)successBlock{
    NSDictionary *headers = @{};
    [ZBRequestManager requestWithConfig:^(ZBURLRequest * _Nullable request) {

        request.server = NSObject.BaseUrl;
        request.url = [request.server stringByAppendingString:NSObject.appLoginPOST.url];
        
        NSLog(@"request.URLString = %@",[request.server stringByAppendingString:request.url]);
        
        request.methodType = ZBMethodTypePOST;//默认为GET
        request.apiType = ZBRequestTypeRefresh;//（默认为ZBRequestTypeRefresh 不读取缓存，不存储缓存）
        request.parameters = parameters;//与公共配置 Parameters 兼容
        request.headers = headers;//与公共配置 Headers 兼容
        request.retryCount = 1;//请求失败 单次请求 重新连接次数 优先级大于 全局设置，不影响其他请求设置
        request.timeoutInterval = 10;//默认30 //优先级 高于 公共配置,不影响其他请求设置
        request.requestSerializer = ZBHTTPRequestSerializer;
        if (![NSString isNullString:[DataManager sharedInstance].tag]) {
            request.userInfo = @{@"info":[DataManager sharedInstance].tag};//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        };//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        
        {
//            request.filtrationCacheKey = @[@""];//与公共配置 filtrationCacheKey 兼容
//            request.requestSerializer = ZBJSONRequestSerializer; //单次请求设置 请求格式 默认JSON，优先级大于 公共配置，不影响其他请求设置
//            request.responseSerializer = ZBJSONResponseSerializer; //单次请求设置 响应格式 默认JSON，优先级大于 公共配置,不影响其他请求设置
           
            /**
             多次请求同一个接口 保留第一次或最后一次请求结果 只在请求时有用  读取缓存无效果。默认ZBResponseKeepNone 什么都不做
             使用场景是在 重复点击造成的 多次请求，如发帖，评论，搜索等业务
             */
//            request.keepType=ZBResponseKeepNone;
        }//一些临时的其他的配置
        
    }progress:^(NSProgress * _Nullable progress){
        NSLog(@"进度 = %f",progress.fractionCompleted * 100);
    }success:^(id  _Nullable responseObject,
               ZBURLRequest * _Nullable request){
        if ([responseObject isKindOfClass:NSDictionary.class]) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            if ([dic[@"code"] intValue] == 200) {
                if (successBlock) {
                    successBlock(responseObject);
                }
            }else{
                [WHToast showErrorWithMessage:dic[@"msg"]
                                     duration:2
                                finishHandler:^{
                  
                }];
            }
        }
    }failure:^(NSError * _Nullable error){
        NSLog(@"error = %@",error);
    }finished:^(id  _Nullable responseObject,
                NSError * _Nullable error,
                ZBURLRequest * _Nullable request){
        NSLog(@"请求完成 userInfo:%@",request.userInfo);
    }];
}
/// 退出
+(void)appLogoutGET:(id)parameters
   withsuccessBlock:(MKDataBlock _Nullable)successBlock{
    NSDictionary *parameterss = @{};
    NSDictionary *headers = @{};
    
    [ZBRequestManager requestWithConfig:^(ZBURLRequest * _Nullable request) {

        request.server = NSObject.BaseUrl;
        request.url = [request.server stringByAppendingString:NSObject.appLogoutGET.url];
        
        NSLog(@"request.URLString = %@",[request.server stringByAppendingString:request.url]);
        
        request.methodType = ZBMethodTypeGET;//默认为GET
        request.apiType = ZBRequestTypeRefresh;//（默认为ZBRequestTypeRefresh 不读取缓存，不存储缓存）
        request.parameters = parameterss;//与公共配置 Parameters 兼容
        request.headers = headers;//与公共配置 Headers 兼容
        request.retryCount = 1;//请求失败 单次请求 重新连接次数 优先级大于 全局设置，不影响其他请求设置
        request.timeoutInterval = 10;//默认30 //优先级 高于 公共配置,不影响其他请求设置
        if (![NSString isNullString:[DataManager sharedInstance].tag]) {
            request.userInfo = @{@"info":[DataManager sharedInstance].tag};//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        };//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        
        {
//            request.filtrationCacheKey = @[@""];//与公共配置 filtrationCacheKey 兼容
//            request.requestSerializer = ZBJSONRequestSerializer; //单次请求设置 请求格式 默认JSON，优先级大于 公共配置，不影响其他请求设置
//            request.responseSerializer = ZBJSONResponseSerializer; //单次请求设置 响应格式 默认JSON，优先级大于 公共配置,不影响其他请求设置
           
            /**
             多次请求同一个接口 保留第一次或最后一次请求结果 只在请求时有用  读取缓存无效果。默认ZBResponseKeepNone 什么都不做
             使用场景是在 重复点击造成的 多次请求，如发帖，评论，搜索等业务
             */
//            request.keepType=ZBResponseKeepNone;
        }//一些临时的其他的配置
        
    }progress:^(NSProgress * _Nullable progress){
        NSLog(@"进度 = %f",progress.fractionCompleted * 100);
    }success:^(id  _Nullable responseObject,
               ZBURLRequest * _Nullable request){
        if ([responseObject isKindOfClass:NSDictionary.class]) {
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            DDResponseModel *model = [DDResponseModel mj_objectWithKeyValues:dataDic];
            // 公共请求错误直接抛出
            if (model.code != HTTPResponseCodeSuccess) {
                [WHToast toastMsg:model.msg];
            }else{
                if (successBlock) {
                    successBlock(model);
                }
            }
        }else{
            [WHToast toastMsg:[@"异常接口" stringByAppendingString:NSObject.userInfoSelectVideoCountPOST.funcName]];
        }
    }
            successBlock(responseObject);
        }
    }failure:^(NSError * _Nullable error){
        NSLog(@"error = %@",error);
    }finished:^(id  _Nullable responseObject,
                NSError * _Nullable error,
                ZBURLRequest * _Nullable request){
        NSLog(@"请求完成 userInfo:%@",request.userInfo);
    }];
}
/// 随机生成4位随机数
+(void)randCodeGET:(id)parameters
  withsuccessBlock:(MKDataBlock _Nullable)successBlock{
    NSDictionary *parameterss = @{};
    NSDictionary *headers = @{};
    
    [ZBRequestManager requestWithConfig:^(ZBURLRequest * _Nullable request) {

        request.server = NSObject.BaseUrl;
        request.url = [request.server stringByAppendingString:NSObject.randCodeGET.url];
        
        NSLog(@"request.URLString = %@",[request.server stringByAppendingString:request.url]);
        
        request.methodType = ZBMethodTypeGET;//默认为GET
        request.apiType = ZBRequestTypeRefresh;//（默认为ZBRequestTypeRefresh 不读取缓存，不存储缓存）
        request.parameters = parameterss;//与公共配置 Parameters 兼容
        request.headers = headers;//与公共配置 Headers 兼容
        request.retryCount = 1;//请求失败 单次请求 重新连接次数 优先级大于 全局设置，不影响其他请求设置
        request.timeoutInterval = 10;//默认30 //优先级 高于 公共配置,不影响其他请求设置
        if (![NSString isNullString:[DataManager sharedInstance].tag]) {
            request.userInfo = @{@"info":[DataManager sharedInstance].tag};//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        };//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        
        {
//            request.filtrationCacheKey = @[@""];//与公共配置 filtrationCacheKey 兼容
//            request.requestSerializer = ZBJSONRequestSerializer; //单次请求设置 请求格式 默认JSON，优先级大于 公共配置，不影响其他请求设置
//            request.responseSerializer = ZBJSONResponseSerializer; //单次请求设置 响应格式 默认JSON，优先级大于 公共配置,不影响其他请求设置
           
            /**
             多次请求同一个接口 保留第一次或最后一次请求结果 只在请求时有用  读取缓存无效果。默认ZBResponseKeepNone 什么都不做
             使用场景是在 重复点击造成的 多次请求，如发帖，评论，搜索等业务
             */
//            request.keepType=ZBResponseKeepNone;
        }//一些临时的其他的配置
        
    }progress:^(NSProgress * _Nullable progress){
        NSLog(@"进度 = %f",progress.fractionCompleted * 100);
    }success:^(id  _Nullable responseObject,
               ZBURLRequest * _Nullable request){
        if ([responseObject isKindOfClass:NSDictionary.class]) {
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            DDResponseModel *model = [DDResponseModel mj_objectWithKeyValues:dataDic];
            // 公共请求错误直接抛出
            if (model.code != HTTPResponseCodeSuccess) {
                [WHToast toastMsg:model.msg];
            }else{
                if (successBlock) {
                    successBlock(model);
                }
            }
        }else{
            [WHToast toastMsg:[@"异常接口" stringByAppendingString:NSObject.userInfoSelectVideoCountPOST.funcName]];
        }
    }
            successBlock(responseObject);
        }
    }failure:^(NSError * _Nullable error){
        NSLog(@"error = %@",error);
    }finished:^(id  _Nullable responseObject,
                NSError * _Nullable error,
                ZBURLRequest * _Nullable request){
        NSLog(@"请求完成 userInfo:%@",request.userInfo);
    }];
}
/// 注册接口(new)
+(void)appRegisterPOST:(id)parameters
      withsuccessBlock:(MKDataBlock _Nullable)successBlock{
    NSDictionary *parameterss = @{};
    NSDictionary *headers = @{};
    
    [ZBRequestManager requestWithConfig:^(ZBURLRequest * _Nullable request) {

        request.server = NSObject.BaseUrl;
        request.url = [request.server stringByAppendingString:NSObject.appRegisterPOST.url];
        
        NSLog(@"request.URLString = %@",[request.server stringByAppendingString:request.url]);
        
        request.methodType = ZBMethodTypePOST;//默认为GET
        request.apiType = ZBRequestTypeRefresh;//（默认为ZBRequestTypeRefresh 不读取缓存，不存储缓存）
        request.parameters = parameterss;//与公共配置 Parameters 兼容
        request.headers = headers;//与公共配置 Headers 兼容
        request.retryCount = 1;//请求失败 单次请求 重新连接次数 优先级大于 全局设置，不影响其他请求设置
        request.timeoutInterval = 10;//默认30 //优先级 高于 公共配置,不影响其他请求设置
        if (![NSString isNullString:[DataManager sharedInstance].tag]) {
            request.userInfo = @{@"info":[DataManager sharedInstance].tag};//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        };//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        
        {
//            request.filtrationCacheKey = @[@""];//与公共配置 filtrationCacheKey 兼容
//            request.requestSerializer = ZBJSONRequestSerializer; //单次请求设置 请求格式 默认JSON，优先级大于 公共配置，不影响其他请求设置
//            request.responseSerializer = ZBJSONResponseSerializer; //单次请求设置 响应格式 默认JSON，优先级大于 公共配置,不影响其他请求设置
           
            /**
             多次请求同一个接口 保留第一次或最后一次请求结果 只在请求时有用  读取缓存无效果。默认ZBResponseKeepNone 什么都不做
             使用场景是在 重复点击造成的 多次请求，如发帖，评论，搜索等业务
             */
//            request.keepType=ZBResponseKeepNone;
        }//一些临时的其他的配置
        
    }progress:^(NSProgress * _Nullable progress){
        NSLog(@"进度 = %f",progress.fractionCompleted * 100);
    }success:^(id  _Nullable responseObject,
               ZBURLRequest * _Nullable request){
        if ([responseObject isKindOfClass:NSDictionary.class]) {
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            DDResponseModel *model = [DDResponseModel mj_objectWithKeyValues:dataDic];
            // 公共请求错误直接抛出
            if (model.code != HTTPResponseCodeSuccess) {
                [WHToast toastMsg:model.msg];
            }else{
                if (successBlock) {
                    successBlock(model);
                }
            }
        }else{
            [WHToast toastMsg:[@"异常接口" stringByAppendingString:NSObject.userInfoSelectVideoCountPOST.funcName]];
        }
    }
            successBlock(responseObject);
        }
    }failure:^(NSError * _Nullable error){
        NSLog(@"error = %@",error);
    }finished:^(id  _Nullable responseObject,
                NSError * _Nullable error,
                ZBURLRequest * _Nullable request){
        NSLog(@"请求完成 userInfo:%@",request.userInfo);
    }];
}
/// 修改密码接口
+(void)resetPasswordPOST:(id)parameters
        withsuccessBlock:(MKDataBlock _Nullable)successBlock{
    NSDictionary *parameterss = @{};
    NSDictionary *headers = @{};
    
    [ZBRequestManager requestWithConfig:^(ZBURLRequest * _Nullable request) {

        request.server = NSObject.BaseUrl;
        request.url = [request.server stringByAppendingString:NSObject.resetPasswordPOST.url];
        
        NSLog(@"request.URLString = %@",[request.server stringByAppendingString:request.url]);
        
        request.methodType = ZBMethodTypePOST;//默认为GET
        request.apiType = ZBRequestTypeRefresh;//（默认为ZBRequestTypeRefresh 不读取缓存，不存储缓存）
        request.parameters = parameterss;//与公共配置 Parameters 兼容
        request.headers = headers;//与公共配置 Headers 兼容
        request.retryCount = 1;//请求失败 单次请求 重新连接次数 优先级大于 全局设置，不影响其他请求设置
        request.timeoutInterval = 10;//默认30 //优先级 高于 公共配置,不影响其他请求设置
        if (![NSString isNullString:[DataManager sharedInstance].tag]) {
            request.userInfo = @{@"info":[DataManager sharedInstance].tag};//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        };//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        
        {
//            request.filtrationCacheKey = @[@""];//与公共配置 filtrationCacheKey 兼容
//            request.requestSerializer = ZBJSONRequestSerializer; //单次请求设置 请求格式 默认JSON，优先级大于 公共配置，不影响其他请求设置
//            request.responseSerializer = ZBJSONResponseSerializer; //单次请求设置 响应格式 默认JSON，优先级大于 公共配置,不影响其他请求设置
           
            /**
             多次请求同一个接口 保留第一次或最后一次请求结果 只在请求时有用  读取缓存无效果。默认ZBResponseKeepNone 什么都不做
             使用场景是在 重复点击造成的 多次请求，如发帖，评论，搜索等业务
             */
//            request.keepType=ZBResponseKeepNone;
        }//一些临时的其他的配置
        
    }progress:^(NSProgress * _Nullable progress){
        NSLog(@"进度 = %f",progress.fractionCompleted * 100);
    }success:^(id  _Nullable responseObject,
               ZBURLRequest * _Nullable request){
        if ([responseObject isKindOfClass:NSDictionary.class]) {
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            DDResponseModel *model = [DDResponseModel mj_objectWithKeyValues:dataDic];
            // 公共请求错误直接抛出
            if (model.code != HTTPResponseCodeSuccess) {
                [WHToast toastMsg:model.msg];
            }else{
                if (successBlock) {
                    successBlock(model);
                }
            }
        }else{
            [WHToast toastMsg:[@"异常接口" stringByAppendingString:NSObject.userInfoSelectVideoCountPOST.funcName]];
        }
    }
            successBlock(responseObject);
        }
    }failure:^(NSError * _Nullable error){
        NSLog(@"error = %@",error);
    }finished:^(id  _Nullable responseObject,
                NSError * _Nullable error,
                ZBURLRequest * _Nullable request){
        NSLog(@"请求完成 userInfo:%@",request.userInfo);
    }];
}
/// 发送短信
+(void)sendSmsCodePOST:(id)parameters
      withsuccessBlock:(MKDataBlock _Nullable)successBlock{
    NSDictionary *parameterss = @{};
    NSDictionary *headers = @{};
    
    [ZBRequestManager requestWithConfig:^(ZBURLRequest * _Nullable request) {

        request.server = NSObject.BaseUrl;
        request.url = [request.server stringByAppendingString:NSObject.sendSmsCodePOST.url];
        
        NSLog(@"request.URLString = %@",[request.server stringByAppendingString:request.url]);
        
        request.methodType = ZBMethodTypePOST;//默认为GET
        request.apiType = ZBRequestTypeRefresh;//（默认为ZBRequestTypeRefresh 不读取缓存，不存储缓存）
        request.parameters = parameterss;//与公共配置 Parameters 兼容
        request.headers = headers;//与公共配置 Headers 兼容
        request.retryCount = 1;//请求失败 单次请求 重新连接次数 优先级大于 全局设置，不影响其他请求设置
        request.timeoutInterval = 10;//默认30 //优先级 高于 公共配置,不影响其他请求设置
        if (![NSString isNullString:[DataManager sharedInstance].tag]) {
            request.userInfo = @{@"info":[DataManager sharedInstance].tag};//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        };//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        
        {
//            request.filtrationCacheKey = @[@""];//与公共配置 filtrationCacheKey 兼容
//            request.requestSerializer = ZBJSONRequestSerializer; //单次请求设置 请求格式 默认JSON，优先级大于 公共配置，不影响其他请求设置
//            request.responseSerializer = ZBJSONResponseSerializer; //单次请求设置 响应格式 默认JSON，优先级大于 公共配置,不影响其他请求设置
           
            /**
             多次请求同一个接口 保留第一次或最后一次请求结果 只在请求时有用  读取缓存无效果。默认ZBResponseKeepNone 什么都不做
             使用场景是在 重复点击造成的 多次请求，如发帖，评论，搜索等业务
             */
//            request.keepType=ZBResponseKeepNone;
        }//一些临时的其他的配置
        
    }progress:^(NSProgress * _Nullable progress){
        NSLog(@"进度 = %f",progress.fractionCompleted * 100);
    }success:^(id  _Nullable responseObject,
               ZBURLRequest * _Nullable request){
        if ([responseObject isKindOfClass:NSDictionary.class]) {
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            DDResponseModel *model = [DDResponseModel mj_objectWithKeyValues:dataDic];
            // 公共请求错误直接抛出
            if (model.code != HTTPResponseCodeSuccess) {
                [WHToast toastMsg:model.msg];
            }else{
                if (successBlock) {
                    successBlock(model);
                }
            }
        }else{
            [WHToast toastMsg:[@"异常接口" stringByAppendingString:NSObject.userInfoSelectVideoCountPOST.funcName]];
        }
    }
            successBlock(responseObject);
        }
    }failure:^(NSError * _Nullable error){
        NSLog(@"error = %@",error);
    }finished:^(id  _Nullable responseObject,
                NSError * _Nullable error,
                ZBURLRequest * _Nullable request){
        NSLog(@"请求完成 userInfo:%@",request.userInfo);
    }];
}

@end
