//
//  RegisterContentView.h
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegisterContentView : UIView

-(void)showRegisterContentViewWithOffsetY:(CGFloat)offsetY;
-(void)removeRegisterContentViewWithOffsetY:(CGFloat)offsetY;

-(void)actionRegisterContentViewBlock:(MKDataBlock)registerContentViewBlock;
-(void)actionRegisterContentViewKeyboardBlock:(MKDataBlock)registerContentViewKeyboardBlock;

@end

NS_ASSUME_NONNULL_END
