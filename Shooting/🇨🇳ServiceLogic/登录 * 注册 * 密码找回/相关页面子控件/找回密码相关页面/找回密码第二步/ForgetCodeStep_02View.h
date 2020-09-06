//
//  ForgetCodeStep_02.h
//  Shooting
//
//  Created by Jobs on 2020/9/6.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ForgetCodeStep_02View : UIView

-(void)showForgetCodeStep_02ViewWithOffsetY:(CGFloat)offsetY;
-(void)removeForgetCodeStep_02ViewWithOffsetY:(CGFloat)offsetY;

-(void)actionForgetCodeStep_02ViewBlock:(MKDataBlock)forgetCodeStep_02ViewBlock;
-(void)actionForgetCodeStep_02ViewKeyboardBlock:(MKDataBlock)forgetCodeStep_02ViewKeyboardBlock;


@end

NS_ASSUME_NONNULL_END
