//
//  DDUserDetailsVC.m
//  DouDong-II
//
//  Created by Jobs on 2021/1/4.
//

#import "DDUserDetailsVC.h"
#import "DDCollectionViewCell_Style2+GKPhotoBrowserDelegate.h"

@interface DDUserDetailsVC ()
<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout
>
// UI
@property(nonatomic,strong)UICollectionViewFlowLayout *layout;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UIColor *bgCor;
@property(nonatomic,weak)UIButton *btn;
// Data
@property(nonatomic,strong)DDInvitationModel *invitationModel;
@property(nonatomic,strong)SaveImageModel *__block saveImageModel;

@end

@implementation DDUserDetailsVC

-(void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

-(void)loadView{
    [super loadView];
    if ([self.requestParams isKindOfClass:DDInvitationModel.class]) {
        self.invitationModel = (DDInvitationModel *)self.requestParams;
        NSLog(@"");
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.setupNavigationBarHidden = YES;
    self.collectionView.alpha = 1;
    self.gk_navLeftBarButtonItem = self.backBtnCategoryItem;
    self.gk_backStyle = GKNavigationBarBackStyleWhite;
    self.gk_navBarAlpha = 0;
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
// 取消关注
-(void)unfollow{
    self.btn.selected = !self.btn.selected;
}
//保存图片
-(void)savePic{
    DDCollectionViewCell_Style2 *cell = (DDCollectionViewCell_Style2 *)[self.collectionView cellForItemAtIndexPath:self.saveImageModel.idxPath];
    [NSObject savePic:cell.browser];
}
#pragma mark - UICollectionViewDataSource
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    return [DDUserDetailsCollectionReusableView collectionReusableViewSizeWithModel:nil];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        DDUserDetailsCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                             withReuseIdentifier:NSStringFromClass(DDUserDetailsCollectionReusableView.class)
                                                                                                    forIndexPath:indexPath];
        
        headerView.indexPath = indexPath;
        [headerView richElementsInCellWithModel:nil];
        @weakify(self)
        [headerView actionBlockUserDetailsCollectionReusableView:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:NSString.class]) {
                NSString *str = (NSString *)data;
                NSNumber *params;
                if ([str isEqualToString:@"IFocusOn"]) {
                    params = @(FocusOnOthers);
                }else if ([str isEqualToString:@"payAttentionToMe"]){
                    params = @(FocusOnMe);
                }else{}
                
                [UIViewController comingFromVC:self
                                          toVC:DDFocusOnPeopleVC.new
                                   comingStyle:ComingStyle_PUSH
                             presentationStyle:UIModalPresentationFullScreen//[UIDevice currentDevice].systemVersion.doubleValue >= 13.0 ? UIModalPresentationAutomatic : UIModalPresentationFullScreen
                                 requestParams:params
                      hidesBottomBarWhenPushed:YES
                                      animated:YES
                                       success:^(id data) {

                }];
            }else if ([data isKindOfClass:UIButton.class]){
                self.btn = (UIButton *)data;
                if ([NSString isNullString:self.btn.titleLabel.text]) {//关注&未关注按钮
                    if (self.btn.selected) {
                        [NSObject showSYSAlertViewTitle:@"是否取消对其关注？"
                                                message:nil
                                        isSeparateStyle:NO
                                            btnTitleArr:@[@"确定",@"取消"]
                                         alertBtnAction:@[@"unfollow",@""]
                                               targetVC:self
                                                 funcInWhere:nil
                                               animated:YES
                                           alertVCBlock:nil
                                        completionBlock:nil];
                    }else{
                        //关注
                        self.btn.selected = !self.btn.selected;
                    }
                }
            }else{}
        }];
        return headerView;
    }else{
        return nil;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (self.invitationModel.imageArr.count || ![NSString isNullString:self.invitationModel.string]) {
        DDCollectionViewCell_Style2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDCollectionViewCell_Style2"
                                                                                      forIndexPath:indexPath];
        cell.idxPath = indexPath;
        [cell actionBlockCollectionViewCell_Style2:^(id data) {
            NSLog(@"点我干嘛");//关注、未关注 按钮点击事件
            if ([data isKindOfClass:UIButton.class]){
                self.btn = (UIButton *)data;
                if ([NSString isNullString:self.btn.titleLabel.text]) {//关注&未关注按钮
                    if (self.btn.selected) {
                        [NSObject showSYSAlertViewTitle:@"是否取消对其关注？"
                                                message:nil
                                        isSeparateStyle:NO
                                            btnTitleArr:@[@"确定",@"取消"]
                                         alertBtnAction:@[@"unfollow",@""]
                                               targetVC:self
                                                 funcInWhere:nil
                                               animated:YES
                                           alertVCBlock:nil
                                        completionBlock:nil];
                    }else{
                        //关注
                        self.btn.selected = !self.btn.selected;
                    }
                }
            }else if ([data isKindOfClass:SaveImageModel.class]){
                self.saveImageModel = (SaveImageModel *)data;
                [NSObject showSYSActionSheetTitle:nil
                                          message:nil
                                  isSeparateStyle:YES
                                      btnTitleArr:@[@"保存图片",@"取消"]
                                   alertBtnAction:@[@"savePic",@"nil"]
                                         targetVC:self.saveImageModel.photoBrowser
                                           funcInWhere:self
                                           sender:nil
                                         animated:YES
                                     alertVCBlock:nil
                                  completionBlock:nil];
            }else{}
        }];
        [cell richElementsInCellWithModel:self.invitationModel];
        return cell;
    }else if (![NSString isNullString:self.invitationModel.adUrlStr]){
        DDCollectionViewCell_Style4 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDCollectionViewCell_Style4"
                                                                                      forIndexPath:indexPath];
        cell.idxPath = indexPath;
        [cell actionBlockCollectionViewCell_Style4:^(id data) {
            NSLog(@"点我干嘛");
        }];
        [cell richElementsInCellWithModel:self.invitationModel];
        return cell;
    }else if (![NSString isNullString:self.invitationModel.playerUrlStr]){
        DDCollectionViewCell_Style5 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDCollectionViewCell_Style5"
                                                                                      forIndexPath:indexPath];
        cell.idxPath = indexPath;
        [cell actionBlockCollectionViewCell_Style5:^(id data) {
            NSLog(@"点我干嘛");
        }];
        [cell richElementsInCellWithModel:self.invitationModel];
        return cell;
    }else{
        return UICollectionViewCell.new;
    }
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return 1;
}
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
}
// 取消选中操作
-(void)collectionView:(UICollectionView *)collectionView
didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
}
#pragma mark —— UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.invitationModel.imageArr || ![NSString isNullString:self.invitationModel.string]) {
        return [DDCollectionViewCell_Style2 cellSizeWithModel:self.invitationModel];
    }else if (![NSString isNullString:self.invitationModel.adUrlStr]){
        return [DDCollectionViewCell_Style4 cellSizeWithModel:self.invitationModel];
    }else if (![NSString isNullString:self.invitationModel.playerUrlStr]){
        return [DDCollectionViewCell_Style5 cellSizeWithModel:self.invitationModel];
    }else{
        return CGSizeZero;
    }
}
///每个item之间的间距 横（行）间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
///每个item之间的间距  列(纵)间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
///内间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout*)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20,
                            12,
                            12,
                            12);
}
#pragma mark —— lazyLoad
-(UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout = UICollectionViewFlowLayout.new;
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }return _layout;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                                       collectionViewLayout:self.layout];
        _collectionView.backgroundColor = self.bgCor;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        _collectionView.mj_header = self.mjRefreshGifHeader;
        _collectionView.mj_header.automaticallyChangeAlpha = YES;//根据拖拽比例自动切换透明度
        
        [_collectionView RegisterClass];

        [self.scrollView addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }return _collectionView;
}

-(UIColor *)bgCor{
    if (!_bgCor) {
        _bgCor = RGBSAMECOLOR(246);
    }return _bgCor;
}

@end
