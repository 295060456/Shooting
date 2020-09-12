//
//  NSObject+Login.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/9/12.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Login)

///登录模块 在适当的时候调用
+(void)Login;
///权限校验
+(void)checkAuthority:(MKDataBlock)checkRes;

@end

NS_ASSUME_NONNULL_END
