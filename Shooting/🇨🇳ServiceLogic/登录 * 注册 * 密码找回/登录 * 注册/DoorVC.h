//
//  DoorVC.h
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Door.h"

NS_ASSUME_NONNULL_BEGIN
//注册和登录共用一个控制器DoorVC；忘记密码单独一个控制器
@interface DoorVC : UIViewController

@property(nonatomic,strong,nullable)LoginContentView *loginContentView;//登录页面
@property(nonatomic,strong)NSString *captchaKey;

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
