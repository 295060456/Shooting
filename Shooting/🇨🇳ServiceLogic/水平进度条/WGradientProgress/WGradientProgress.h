//
//  WGradientProgress.h
//  WGradientProgressDemo
//
//  Created by zilin_weng on 15/7/19.
//  Copyright (c) 2015年 Weng-Zilin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGradientProgress : UIView

@property(nonatomic,assign)CGFloat progress;

- (void)showOnParent:(UIView *)parentView;

- (void)hide;

@end
