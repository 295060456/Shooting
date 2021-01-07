//
//  DDCollectionViewCell_Style2+UICollectionViewDataSource.m
//  DouDong-II
//
//  Created by Jobs on 2021/1/6.
//

#import "DDCollectionViewCell_Style2+UICollectionViewDataSource.h"

@implementation DDCollectionViewCell_Style2 (UICollectionViewDataSource)

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DDCollectionViewCell_Style3 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDCollectionViewCell_Style3"
                                                                                  forIndexPath:indexPath];
    [cell actionBlockCollectionViewCell_Style3:^(id data) {
        NSLog(@"点我干嘛");//关注、未关注 按钮点击事件
    }];
    [cell richElementsInCellWithModel:self.invitationModel.imageArr[indexPath.row]];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.invitationModel.imageArr.count;//有多少张图片
}

@end
