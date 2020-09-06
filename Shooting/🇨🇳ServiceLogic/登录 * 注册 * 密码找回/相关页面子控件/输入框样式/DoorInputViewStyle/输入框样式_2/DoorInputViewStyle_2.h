//
//  DoorInputViewStyle_2.h
//  Shooting
//
//  Created by Jobs on 2020/9/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoorInputViewStyle.h"
#import "ImageCodeView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DoorInputViewStyle_2 : DoorInputViewStyle

@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)ZYTextField *tf;
@property(nonatomic,strong)ImageCodeView *imageCodeView;
@property(nonatomic,assign)CGFloat inputViewWidth;

@end

NS_ASSUME_NONNULL_END
