//
//  DDPlazaCommunityVC.m
//  DouDong-II
//
//  Created by Jobs on 2020/12/26.
//

#import "DDPlazaCommunityVC.h"

@interface DDPlazaCommunityVC ()

@end

@implementation DDPlazaCommunityVC

-(void)loadView{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.setupNavigationBarHidden = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = kWhiteColor;

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    Ivar collectionViewIvar = class_getInstanceVariable(self.class, "_collectionView");//必须是下划线接属性
    UICollectionView *collectionView = object_getIvar(self, collectionViewIvar);
    collectionView.y = 40;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}
#pragma mark —— UICollectionViewDelegateFlowLayout
///内间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout*)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0,
                            12,
                            12,
                            12);
}

@end
