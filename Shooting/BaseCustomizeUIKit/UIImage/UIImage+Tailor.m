//
//  UIImage+tailor.m
//  Shooting
//
//  Created by Jobs on 2020/8/30.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UIImage+Tailor.h"

@implementation UIImage (Tailor)

/// 以图片中心为中心，以最小边为边长，裁剪正方形图片
+(UIImage *)cropSquareImage:(UIImage *)image{
    
    CGImageRef sourceImageRef = [image CGImage];//将UIImage转换成CGImageRef
    
    CGFloat _imageWidth = image.size.width * image.scale;
    CGFloat _imageHeight = image.size.height * image.scale;
    CGFloat _width = _imageWidth > _imageHeight ? _imageHeight : _imageWidth;
    CGFloat _offsetX = (_imageWidth - _width) / 2;
    CGFloat _offsetY = (_imageHeight - _width) / 2;
    
    CGRect rect = CGRectMake(_offsetX, _offsetY, _width, _width);
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);//按照给定的矩形区域进行剪裁
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    return newImage;
}

@end
