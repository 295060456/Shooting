//
//  WGradientProgressLab.h
//  Shooting
//
//  Created by Jobs on 2020/9/9.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WGradientProgressView : UIView

@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)UIImage *img;

@property(nonatomic,strong)UIFont *titleFont;
@property(nonatomic,strong)UIColor *titleColor;


@end

NS_ASSUME_NONNULL_END
