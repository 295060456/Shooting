//
//  DDUserInfo.m
//  DouDong-II
//
//  Created by Jobs on 2020/12/19.
//

#import "DDUserInfo.h"

static NSString *userInfoKey = @"userinfoKey";
static NSString *PostDraftURLKey = @"PostDraftURL";

@implementation DDUserInfo

@synthesize postDraftURLStr = _postDraftURLStr;
@synthesize userModel = _userModel;

static DDUserInfo *static_userInfo = nil;

+(instancetype)sharedInstance{
    @synchronized(self){
        if (!static_userInfo) {
            static_userInfo = DDUserInfo.new;
        }
    }return static_userInfo;
}

-(instancetype)init{
    if (self = [super init]) {
        static_userInfo = self;
    }return self;
}
//鉴别是否登录的标准：userIdKey值对应的token是否为空
-(BOOL)isLogin{
    DDUserModel *model = [DDUserModel mj_objectWithKeyValues:[UserDefaultManager fetchDataWithKey:userInfoKey]];
    return ![NSString isNullString:model.token];
}
#pragma mark —— userModel
-(void)setUserModel:(DDUserModel *)userModel{
    _userModel = userModel;
    //先清
    [UserDefaultManager cleanDataWithKey:userInfoKey];
    //后装
    [UserDefaultManager saveValue:userModel
                           forKey:userInfoKey];
}

-(DDUserModel *)userModel{
    NSString *userinfo = [UserDefaultManager fetchDataWithKey:userInfoKey];
    if (userinfo.length) {
        _userModel = [DDUserModel mj_objectWithKeyValues:userinfo];
    }return _userModel;
}
#pragma mark —— postDraftURLStr
-(void)setPostDraftURLStr:(NSString *)postDraftURLStr{
    _postDraftURLStr = postDraftURLStr;
    //先清
    [UserDefaultManager cleanDataWithKey:PostDraftURLKey];
    //后装
    [UserDefaultManager saveValue:postDraftURLStr
                           forKey:PostDraftURLKey];
}

-(NSString *)postDraftURLStr{
    return (NSString *)[UserDefaultManager fetchDataWithKey:PostDraftURLKey];
}

@end
