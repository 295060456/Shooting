//
//  UIImage+Overlay.m
//  Shooting
//
//  Created by Jobs on 2020/8/30.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UIImage+Overlay.h"

@implementation UIImage (Overlay)
///融合两个图片为一个新图
+(UIImage *)addImage:(UIImage *)image1
           withImage:(UIImage *)image2{
    UIGraphicsBeginImageContext(image1.size);
    [image1 drawInRect:CGRectMake(0,
                                  0,
                                  image1.size.width,
                                  image1.size.height)];
    [image2 drawInRect:CGRectMake((image1.size.width - image2.size.width) / 2,
                                  (image1.size.height - image2.size.height) / 2,
                                  image2.size.width * 2,
                                  image2.size.height * 2)];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

@end
