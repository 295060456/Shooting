//
//  DDUserInfo.h
//  DouDong-II
//
//  Created by Jobs on 2020/12/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// 本类只管理用户数据的存取，数据存储在NSUserDefault里
@interface DDUserInfo : NSObject

@property(nonatomic,strong)NSString *token;
@property(nonatomic,strong)NSString *postDraftURLStr;//用户发帖的文本草稿本地存储地址

+(instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
