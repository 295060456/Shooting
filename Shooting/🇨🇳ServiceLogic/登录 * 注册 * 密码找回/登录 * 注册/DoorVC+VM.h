//
//  DoorVC+VM.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/9/12.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "DoorVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DoorVC (VM)

///登录
-(void)login_networkingWithUserName:(NSString *)account
                           passWord:(NSString *)password
                         originType:(originType)originType;
///注册
- (void)register_networkingWithAccount:(NSString *)account
                              password:(NSString *)password
                       confirmPassword:(NSString *)confirmPassword
                            captchaKey:(NSString *)captchaKey
                               imgCode:(NSString *)imgCode
                            originType:(originType)originType;
-(void)clearTF;

@end

NS_ASSUME_NONNULL_END
