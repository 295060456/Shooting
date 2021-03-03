//
//  DDFansMsgModel.h
//  DouDong-II
//
//  Created by Jobs on 2020/12/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//粉丝消息
@interface DDFansMsgModel : NSObject

@property(nonatomic,strong)UIImage *userHeaderIMG;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *userSignature;

@end

NS_ASSUME_NONNULL_END
