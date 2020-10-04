//
//  AESCrypt.h
//  GS_Jzfp
//
//  Created by 董向坤 on 2019/6/19.
//  Copyright © 2019 Dongxk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AESCrypt : NSObject

/**
 *  AES 字符串加密方法(见下)已经修改合适,其他方法见.m  由于时间原因 暂时未修改  按以下方法修改即可
 */
+ (NSString *)aesEncryptStringWithContent:(NSString *)content key:(NSString *)key;

+ (NSString *)aesDecryptStringWithContent:(NSString *)content key:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
