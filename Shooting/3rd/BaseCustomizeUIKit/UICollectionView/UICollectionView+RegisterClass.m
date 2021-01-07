//
//  UICollectionView+RegisterClass.m
//  UBallLive
//
//  Created by Jobs on 2020/10/31.
//

#import "UICollectionView+RegisterClass.h"

@implementation UICollectionView (RegisterClass)

-(void)RegisterClass{
    
    [self registerClass:DDUserDetailsCollectionReusableView.class
    forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
    withReuseIdentifier:@"DDUserDetailsCollectionReusableView"];
    
    [self registerClass:DDCollectionViewCell_Style1.class
        forCellWithReuseIdentifier:@"DDCollectionViewCell_Style1"];
    [self registerClass:DDCollectionViewCell_Style2.class
        forCellWithReuseIdentifier:@"DDCollectionViewCell_Style2"];
    [self registerClass:DDCollectionViewCell_Style3.class
        forCellWithReuseIdentifier:@"DDCollectionViewCell_Style3"];
    [self registerClass:DDCollectionViewCell_Style4.class
        forCellWithReuseIdentifier:@"DDCollectionViewCell_Style4"];
    [self registerClass:DDCollectionViewCell_Style5.class
        forCellWithReuseIdentifier:@"DDCollectionViewCell_Style5"];
}

@end
