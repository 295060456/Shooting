//
//  LoginContentView.h
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoorInputView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginContentView : UIView

@property(nonatomic,strong)NSMutableArray <DoorInputViewStyle_3 *> *inputViewMutArr;

///记住账户和密码：前提条件（登录成功以后）
-(void)storeAcc_Code;

-(void)showLoginContentViewWithOffsetY:(CGFloat)offsetY;
-(void)removeLoginContentViewWithOffsetY:(CGFloat)offsetY;

-(void)actionLoginContentViewBlock:(MKDataBlock)loginContentViewBlock;//各种按钮的点击事件回调
-(void)actionLoginContentViewKeyboardBlock:(MKDataBlock)loginContentViewKeyboardBlock;

@end

NS_ASSUME_NONNULL_END
