//
//  DDCollectionViewCell_Style2+GKPhotoBrowserDelegate.m
//  DouDong-II
//
//  Created by Jobs on 2020/12/28.
//

#import "DDCollectionViewCell_Style2+GKPhotoBrowserDelegate.h"

@implementation DDCollectionViewCell_Style2 (GKPhotoBrowserDelegate)

// 滚动到一半时索引改变
- (void)photoBrowser:(GKPhotoBrowser *)browser
     didChangedIndex:(NSInteger)index{
    NSLog(@"%s", __FUNCTION__);
}
// 选择photoView时回调
- (void)photoBrowser:(GKPhotoBrowser *)browser
    didSelectAtIndex:(NSInteger)index{
    NSLog(@"%s", __FUNCTION__);
}
// 单击事件
- (void)photoBrowser:(GKPhotoBrowser *)browser
  singleTapWithIndex:(NSInteger)index{
    NSLog(@"%s", __FUNCTION__);
}
// 长按事件
- (void)photoBrowser:(GKPhotoBrowser *)browser
  longPressWithIndex:(NSInteger)index{
    NSLog(@"%s", __FUNCTION__);
    if (self.collectionViewCell_Style2Block) {
        
        SaveImageModel *model = SaveImageModel.new;
        model.idxPath = self.idxPath;
        model.longPressWithIndex = index;
        model.cell = self;
        model.photoBrowser = browser;
        
        self.collectionViewCell_Style2Block(model);
    }
}
// 旋转事件
- (void)photoBrowser:(GKPhotoBrowser *)browser
onDeciceChangedWithIndex:(NSInteger)index
         isLandscape:(BOOL)isLandscape{
    NSLog(@"%s", __FUNCTION__);
}
// 上下滑动消失
// 开始滑动时
- (void)photoBrowser:(GKPhotoBrowser *)browser
   panBeginWithIndex:(NSInteger)index{
    NSLog(@"%s", __FUNCTION__);
}
// 结束滑动时 disappear：是否消失
- (void)photoBrowser:(GKPhotoBrowser *)browser
   panEndedWithIndex:(NSInteger)index
       willDisappear:(BOOL)disappear{
    NSLog(@"%s", __FUNCTION__);
}
// 布局子视图
- (void)photoBrowser:(GKPhotoBrowser *)browser
  willLayoutSubViews:(NSInteger)index{
    NSLog(@"%s", __FUNCTION__);
}
// browser完全消失回调
- (void)photoBrowser:(GKPhotoBrowser *)browser
 didDisappearAtIndex:(NSInteger)index{
    NSLog(@"%s", __FUNCTION__);
}
// browser自定义加载方式时回调
- (void)photoBrowser:(GKPhotoBrowser *)browser
    loadImageAtIndex:(NSInteger)index
            progress:(float)progress
       isOriginImage:(BOOL)isOriginImage{
    NSLog(@"%s", __FUNCTION__);
}
// browser加载失败自定义弹窗
- (void)photoBrowser:(GKPhotoBrowser *)browser
   loadFailedAtIndex:(NSInteger)index{
    NSLog(@"%s", __FUNCTION__);
}
// browser UIScrollViewDelegate
- (void)photoBrowser:(GKPhotoBrowser *)browser
 scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%s", __FUNCTION__);
}

- (void)photoBrowser:(GKPhotoBrowser *)browser
scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"%s", __FUNCTION__);
}

- (void)photoBrowser:(GKPhotoBrowser *)browser
scrollViewDidEndDragging:(UIScrollView *)scrollView
      willDecelerate:(BOOL)decelerate{
    NSLog(@"%s", __FUNCTION__);
}

@end

@implementation SaveImageModel

@end


