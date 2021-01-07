//
//  UICollectionView+RegisterClass.h
//  UBallLive
//
//  Created by Jobs on 2020/10/31.
//

#import <UIKit/UIKit.h>

#import "DDCollectionViewCell_Style1.h"
#import "DDCollectionViewCell_Style2.h"
#import "DDCollectionViewCell_Style3.h"
#import "DDCollectionViewCell_Style4.h"
#import "DDCollectionViewCell_Style5.h"
#import "DDUserDetailsCollectionReusableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (RegisterClass)
//注册的时候不开辟内存，只有当用字符串进行取值的时候才开辟内存
-(void)RegisterClass;

@end

NS_ASSUME_NONNULL_END
