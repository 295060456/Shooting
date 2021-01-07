//
//  DDCollectionViewCell_Style2+UICollectionViewDelegate.m
//  DouDong-II
//
//  Created by Jobs on 2021/1/6.
//

#import "DDCollectionViewCell_Style2+UICollectionViewDelegate.h"

@implementation DDCollectionViewCell_Style2 (UICollectionViewDelegate)

#pragma mark —— UICollectionViewDelegate
//允许选中时，高亮
-(BOOL)collectionView:(UICollectionView *)collectionView
shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
    return YES;
}
// 高亮完成后回调
-(void)collectionView:(UICollectionView *)collectionView
didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
}
// 由高亮转成非高亮完成时的回调
-(void)collectionView:(UICollectionView *)collectionView
didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
}
// 设置是否允许选中
-(BOOL)collectionView:(UICollectionView *)collectionView
shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
    return YES;
}
// 设置是否允许取消选中
-(BOOL)collectionView:(UICollectionView *)collectionView
shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
    return YES;
}
// 选中操作
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
    extern DDInvitationVC *invitationVC;
    self.selectCell = (DDCollectionViewCell_Style3 *)[collectionView cellForItemAtIndexPath:indexPath];

    [self.invitationModel.imageArr enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj,
                                                                NSUInteger idx,
                                                                BOOL * _Nonnull stop) {
        GKPhoto *photo = GKPhoto.new;
        photo.image = obj;
//        photo.placeholderImage =
        [self.photosMutArr addObject:photo];
    }];
    
    GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:self.photosMutArr
                                                        currentIndex:0];
    [browser makeCustomSaveBtn];
    
    browser.showStyle           = GKPhotoBrowserShowStyleNone;
    browser.hideStyle           = GKPhotoBrowserHideStyleZoomScale;
    browser.isSingleTapDisabled = YES;  // 不响应默认单击事件
    browser.isStatusBarShow     = YES;  // 显示状态栏
    browser.isHideSourceView    = NO;
    browser.delegate            = self;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        browser.isFollowSystemRotation = YES;
    }
    
//    [browser setupCoverViews:@[]
//                 layoutBlock:^(GKPhotoBrowser * _Nonnull photoBrowser,
//                               CGRect superFrame) {
//    }];

    [browser showFromVC:invitationVC];
    self.isCoverShow = YES;
    self.browser = browser;
}
// 取消选中操作
-(void)collectionView:(UICollectionView *)collectionView
didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
}

@end
