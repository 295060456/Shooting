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

-(void)showLoginContentViewWithOffsetY:(CGFloat)offsetY;
-(void)removeLoginContentViewWithOffsetY:(CGFloat)offsetY;

-(void)actionLoginContentViewBlock:(MKDataBlock)loginContentViewBlock;
-(void)actionLoginContentViewKeyboardBlock:(MKDataBlock)loginContentViewKeyboardBlock;

@end

NS_ASSUME_NONNULL_END
