//
//  AuthCodeLab.h
//  DouDong-II
//
//  Created by Jobs on 2020/12/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AuthCodeModel : NSObject

@property(nonatomic,strong)NSString *captchaKey;
@property(nonatomic,strong)NSString *imgCode;

@end

@interface AuthCodeLab : UILabel

@property(nonatomic,strong)AuthCodeModel *__block authCodeModel;

@end

NS_ASSUME_NONNULL_END
