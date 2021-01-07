//
//  DDUserInfo.m
//  DouDong-II
//
//  Created by Jobs on 2020/12/19.
//

#import "DDUserInfo.h"

@implementation DDUserInfo

@synthesize token = _token;
@synthesize postDraftURLStr = _postDraftURLStr;

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

-(void)setToken:(NSString *)token{
    _token = token;
    //先清
    [UserDefaultManager cleanDataWithKey:@"Authorization"];
    //后装
    UserDefaultModel *userDefaultModel = UserDefaultModel.new;
    userDefaultModel.key = @"Authorization";
    userDefaultModel.obj = token;
    [UserDefaultManager storedData:userDefaultModel];
}

-(NSString *)token{
    return (NSString *)[UserDefaultManager fetchDataWithKey:@"Authorization"];
}

-(void)setPostDraftURLStr:(NSString *)postDraftURLStr{
    _postDraftURLStr = postDraftURLStr;
    //先清
    [UserDefaultManager cleanDataWithKey:@"PostDraftURL"];
    //后装
    UserDefaultModel *userDefaultModel = UserDefaultModel.new;
    userDefaultModel.key = @"PostDraftURL";
    userDefaultModel.obj = postDraftURLStr;
    [UserDefaultManager storedData:userDefaultModel];
}

-(NSString *)postDraftURLStr{
    return (NSString *)[UserDefaultManager fetchDataWithKey:@"PostDraftURL"];
}

@end
