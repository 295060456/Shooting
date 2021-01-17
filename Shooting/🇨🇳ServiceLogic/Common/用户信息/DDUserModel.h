//
//  DDUserModel.h
//  DouDong-II
//
//  Created by xxx on 2021/1/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDUserModel : NSObject

@property(nonatomic,copy)NSString *account;
@property(nonatomic,copy)NSString *nickName;
@property(nonatomic,copy)NSString *tel;
@property(nonatomic,copy)NSString *token;
@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *age;
@property(nonatomic,copy)NSString *area;
@property(nonatomic,copy)NSString *sex;
@property(nonatomic,copy)NSString *balance;
@property(nonatomic,copy)NSString *headImage;
@end

NS_ASSUME_NONNULL_END
