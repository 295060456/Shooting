//
//  ForgetCodeStep_01.h
//  Shooting
//
//  Created by Jobs on 2020/9/6.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ForgetCodeStep_01View : UIView

-(void)showForgetCodeStep_01ViewWithOffsetY:(CGFloat)offsetY;
-(void)removeForgetCodeStep_01ViewWithOffsetY:(CGFloat)offsetY;

-(void)actionForgetCodeStep_01ViewBlock:(MKDataBlock)forgetCodeStep_01ViewBlock;
-(void)actionForgetCodeStep_02ViewKeyboardBlock:(MKDataBlock)forgetCodeStep_01ViewKeyboardBlock;

@end

NS_ASSUME_NONNULL_END
