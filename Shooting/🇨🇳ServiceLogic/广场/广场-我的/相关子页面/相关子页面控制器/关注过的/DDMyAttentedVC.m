//
//  DDMyAttentedVC.m
//  DouDong-II
//
//  Created by Jobs on 2020/12/26.
//

#import "DDMyAttentedVC.h"

@interface DDMyAttentedVC ()


@end

@implementation DDMyAttentedVC

-(void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    Ivar collectionViewIvar = class_getInstanceVariable(self.class, "_collectionView");//必须是下划线接属性
    UICollectionView *collectionView = object_getIvar(self, collectionViewIvar);
    collectionView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@"暂无数据"
                                                            titleStr:@"还没关注过任何用户哦"
                                                           detailStr:@""];
    
    Ivar dataMutArrIvar = class_getInstanceVariable(self.class, "_dataMutArr");//必须是下划线接属性
    NSMutableArray *dataMutArr = object_getIvar(self, dataMutArrIvar);
    
    if (dataMutArr.count) {
        [collectionView ly_hideEmptyView];
    }else{
        [collectionView ly_showEmptyView];
    }
}
///下拉刷新
-(void)pullToRefresh{
    NSLog(@"下拉刷新");
    Ivar ivar = class_getInstanceVariable([DDInvitationVC class], "_collectionView");//必须是下划线接属性
    UICollectionView *collectionView = object_getIvar(self, ivar);
    // 初始化
    [collectionView.mj_header endRefreshing];// 结束刷新
    if (!collectionView.mj_footer.hidden) {
        [collectionView.mj_footer endRefreshing];// 结束刷新
    }
}
///上拉加载更多
- (void)loadMoreRefresh{
    NSLog(@"上拉加载更多");
    Ivar ivar = class_getInstanceVariable([DDInvitationVC class], "_collectionView");//必须是下划线接属性
    UICollectionView *collectionView = object_getIvar(self, ivar);
    [collectionView.mj_header endRefreshing];// 结束刷新
    if (!collectionView.mj_footer.hidden) {
        [collectionView.mj_footer endRefreshing];// 结束刷新
    }
}

@end
