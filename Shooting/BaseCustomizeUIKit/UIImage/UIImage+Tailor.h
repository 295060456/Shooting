//
//  UIImage+tailor.h
//  Shooting
//
//  Created by Jobs on 2020/8/30.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Tailor)

/// 以图片中心为中心，以最小边为边长，裁剪正方形图片
+(UIImage *)cropSquareImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
