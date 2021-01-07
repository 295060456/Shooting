//
//  NSObject+URLManager.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "NSObject+URLManager.h"

@implementation NSObject (URLManager)
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
+(URLManagerModel *)url:(NSString *)url
               funcName:(NSString *)funcName{
    URLManagerModel *managerModel = URLManagerModel.new;
    managerModel.url = url;
    managerModel.funcName = funcName;
    return managerModel;
}
#pragma mark —— BaseURL
+(NSString *)BaseUrl_1{
#if DEBUG
//    return @"http://172.24.135.55/api";//开发环境
    return @"http://222.186.150.148/api/";//开发环境
#elif
    return @"http://172.24.135.54/api";//测试环境
//    return @"https://www.xiuwa.top/api/"//生产环境
#endif
}

+(NSString *)BaseUrl_H5{
#if DEBUG
    return @"http://172.24.135.54/taskpage";//开发环境
#elif
    return @"http://172.24.135.54/taskpage";//测试环境
//    return @"https://www.xiuwa.top/h5/"//生产环境
#endif
}
#pragma mark —— port
+(NSString *)BasePort{
    return @"";//测试环境
//#if DEBUG
//    return @"";//测试环境
//#elif
//    return @"";//开发环境
//#endif
}
#pragma mark —— 数据统计相关接口
///活跃用户 POST
+(URLManagerModel *)addActiveUserDataPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/statistics/addActiveUserData"]
                funcName:NSStringFromSelector(_cmd)];
}
///启动次数 POST
+(URLManagerModel *)addStartTimePOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/statistics/addStartTime"]
                funcName:NSStringFromSelector(_cmd)];
}
///使用时长 POST
+(URLManagerModel *)addUseTimeDataPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/statistics/addUseTimeData"]
                funcName:NSStringFromSelector(_cmd)];
}
///渠道列表 GET
+(URLManagerModel *)channelListGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/statistics/channelList"]
                funcName:NSStringFromSelector(_cmd)];
}
///版本信息 GET
+(URLManagerModel *)versionInfoAppGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/statistics/versionInfo"]
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— APP登录信息相关接口
///找回密码接口-重置密码 POST
+(URLManagerModel *)changePasswordPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/login/changePassword"]
                funcName:NSStringFromSelector(_cmd)];
}
///找回密码接口-身份验证 POST
+(URLManagerModel *)checkIdentityPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/login/checkIdentity"]
                funcName:NSStringFromSelector(_cmd)];
}
///登录接口 POST
+(URLManagerModel *)appLoginPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/login/login"]
                funcName:NSStringFromSelector(_cmd)];
}
///退出接口 GET
+(URLManagerModel *)appLogoutGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/login/out"]
                funcName:NSStringFromSelector(_cmd)];
}
///随机生成4位随机数 GET
+(URLManagerModel *)randCodeGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/login/randCode"]
                funcName:NSStringFromSelector(_cmd)];
}
///注册接口(new) POST
+(URLManagerModel *)appRegisterPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/login/register"]
                funcName:NSStringFromSelector(_cmd)];
}
///修改密码接口 POST
+(URLManagerModel *)resetPasswordPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/login/resetPassword"]
                funcName:NSStringFromSelector(_cmd)];
}
///发送短信 POST
+(URLManagerModel *)sendSmsCodePOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/login/sendSmsCode"]
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— APP广告相关接口
///查询开屏或视频广告 GET
+(URLManagerModel *)adInfoGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/adInfo/adInfo"]
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— APP好友关系相关接口
///手动执行奖励记录 GET
+(URLManagerModel *)addAwardGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/userFriend/addAward"]
                funcName:NSStringFromSelector(_cmd)];
}
///手动执行奖励记录 GET
+(URLManagerModel *)addAwardInfoGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/userFriend/addAwardInfo"]
                funcName:NSStringFromSelector(_cmd)];
}
///获取活跃用户 GET
+(URLManagerModel *)awardListGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/userFriend/awardList"]
                funcName:NSStringFromSelector(_cmd)];
}
///最新四个好友 GET
+(URLManagerModel *)fourListGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/userFriend/fourList"]
                funcName:NSStringFromSelector(_cmd)];
}
///selectUrl GET
+(URLManagerModel *)friendUrlselectUrlGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/userFriend/friendUrl"]
                funcName:NSStringFromSelector(_cmd)];
}
///好友列表 GET
+(URLManagerModel *)userFriendListGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/userFriend/list"]
                funcName:NSStringFromSelector(_cmd)];
}
///统计我的收益 GET
+(URLManagerModel *)myInComeGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/userFriend/myInCome"]
                funcName:NSStringFromSelector(_cmd)];
}
///面对面邀请保存好友手机号码 POST
+(URLManagerModel *)savePhonePOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/userFriend/savePhone"]
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— APP黑名单相关接口
/// 添加 POST
+(URLManagerModel *)blackListAddPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/black/add"]
                funcName:NSStringFromSelector(_cmd)];
}
///删除 GET
+(URLManagerModel *)blackListDeleteGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/black/delete"]
                funcName:NSStringFromSelector(_cmd)];
}
///黑名单列表 GET
+(URLManagerModel *)blackListGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/black/list"]
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— APP获取配置信息
///app启动参数 GET
+(URLManagerModel *)refreshGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/sys/refresh"]
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— APP看视频获得金币奖励
/// 首页宝箱奖励 POST
+(URLManagerModel *)boxRewardPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/reward/boxReward"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 抖币领取开关 GET
+(URLManagerModel *)goldSwitchGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/reward/goldSwitch"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 抖币领取开关 POST
+(URLManagerModel *)goldSwitchPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/reward/goldSwitch"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 首页看视频得抖币奖励 POST
+(URLManagerModel *)randomRewardPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/reward/randomReward"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 首页看视频得抖币配置 GET
+(URLManagerModel *)rewardSnapshotGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/reward/rewardSnapshot"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 首页看视频得抖币配置 POST
+(URLManagerModel *)rewardSnapshotPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/reward/rewardSnapshot"]
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— APP评论相关接口
/// 评论视频 POST
+(URLManagerModel *)commentVideoPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/comment/commentVideo"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 删除评论 POST
+(URLManagerModel *)delCommentPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/comment/delComment"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 初始化用户评论列表 GET
+(URLManagerModel *)queryInitListGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/comment/queryInitList"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 获取回复列表 GET
+(URLManagerModel *)queryReplyListGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/comment/queryReplyList"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 回复评论 POST
+(URLManagerModel *)replyCommentPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/comment/replyComment"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 点赞或取消点赞 POST
+(URLManagerModel *)setPraisePOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/comment/setPraise"]
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— APP钱包相关接口
/// 抖币兑换余额提示 GET
+(URLManagerModel *)chargeBalanceTipsGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/wallet/chargeBalanceTips"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 金币兑换 POST
+(URLManagerModel *)chargeGoldPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/wallet/chargeGold"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 余额兑换会员 POST
+(URLManagerModel *)chargeVipPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/wallet/chargeVIP"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 获取余额兑换会员类型下拉框 GET
+(URLManagerModel *)getToMemTypeGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/wallet/getToMemType"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 获取提现兑换类型下拉框 GET
+(URLManagerModel *)getWithdrawTypeGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/wallet/getWithdrawType"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 我的钱包流水 POST
+(URLManagerModel *)myFlowsPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/wallet/myFlows"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 获取用户信息 POST
+(URLManagerModel *)myWalletPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/wallet/myWallet"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 余额提现 POST
+(URLManagerModel *)withdrawBalancePOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/wallet/withdrawBalance"]
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— APP视频相关接口
/// 删除自己发布的视频 POST
+(URLManagerModel *)delAppVideoPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/videos/delAppVideo"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 标签列表 GET
+(URLManagerModel *)labelListGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/videos/labelList"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 视频列表(关注、点赞)  POST
+(URLManagerModel *)loadVideosPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/videos/loadVideos"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 视频点赞or取消 POST
+(URLManagerModel *)praiseVideoPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/videos/praiseVideo"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 生成上传链接 POST
+(URLManagerModel *)presignedUploadUrlPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/videos/presignedUploadUrl"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 推荐的视频列表 POST
+(URLManagerModel *)recommendVideosPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/videos/recommendVideos"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 搜索视频 POST
+(URLManagerModel *)searchPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/videos/search"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 上传视频 POST
+(URLManagerModel *)uploadVideoPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/videos/uploadVideo"]
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— App消息相关接口
/// 获取用户粉丝详情 GET
+(URLManagerModel *)fansInfoGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/message/fansInfo"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 消息一级列表 GET
+(URLManagerModel *)messageFirstClassListGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/message/list"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 获取系统消息详情视频列表 GET
+(URLManagerModel *)messageInfoGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/message/messageInfo"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 消息二级级列表 GET
+(URLManagerModel *)messageSecondClassListGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/message/messageList"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 公告列表 GET
+(URLManagerModel *)noticeListGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/message/noticeList"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 消息开关列表 GET
+(URLManagerModel *)turnOffListGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/message/turnOffList"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 修改消息开关 POST
+(URLManagerModel *)updateOffPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/message/updateOff"]
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— App消息状态相关接口
/// 添加已读消息 POST
+(URLManagerModel *)messageStatusAddPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/messageStatus/add"]
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— APP银行卡相关接口
/// 添加银行卡 POST
+(URLManagerModel *)bankAddPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/bank/add"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 获取银行卡信息 GET
+(URLManagerModel *)bankInfoGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/bank/bankInfo"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 删除 GET
+(URLManagerModel *)bankDeleteGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/bank/delete"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 银行卡列表 GET
+(URLManagerModel *)bankListGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/bank/list"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 修改银行卡 POST
+(URLManagerModel *)bankUpdatePOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/bank/update"]
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— APP用户粉丝相关接口
///用户粉丝列表 GET
+(URLManagerModel *)userFansListGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/userFans/list"]
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— APP用户关注相关接口
/// 添加 POST
+(URLManagerModel *)userFocusAddPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/userFocus/add"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 删除 GET
+(URLManagerModel *)userFocusDeleteGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/userFocus/delete"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 关注用户列表 GET
+(URLManagerModel *)userFocusListGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/userFocus/list"]
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— APP用户信息相关接口
/// 绑定手机号 POST
+(URLManagerModel *)bindPhonePOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/userInfo/bindPhone"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 校验是否有权限 GET
+(URLManagerModel *)checkHadRoleGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/userInfo/checkHadRole"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 进行签到 POST
+(URLManagerModel *)doSignPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/userInfo/doSign"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 获取我的详情 GET
+(URLManagerModel *)myUserInfoGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/userInfo/myUserInfo"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 滚动数据 GET
+(URLManagerModel *)rollDateGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/userInfo/rollDate"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 查询用户信息 GET
+(URLManagerModel *)selectIdCardGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/userInfo/selectIdCard"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 我的签到列表 GET
+(URLManagerModel *)signListGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/userInfo/signList"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 编辑个人资料 POST
+(URLManagerModel *)userInfoUpdatePOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/userInfo/update"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 绑定支付宝 POST
+(URLManagerModel *)updateAccountInfoPOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/userInfo/updateAccountInfo"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 邀请好友 POST
+(URLManagerModel *)userInfoUpdateCodePOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/userInfo/updateCode"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 上传头像 POST
+(URLManagerModel *)uploadImagePOST{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/userInfo/uploadImage"]
                funcName:NSStringFromSelector(_cmd)];
}
/// 获取用户详情 GET
+(URLManagerModel *)userInfoGET{
    return [NSObject url:[NSObject.BasePort stringByAppendingString:@"app/userInfo/userInfo"]
                funcName:NSStringFromSelector(_cmd)];
}
@end
