//
//  DDInvitationVC.m
//  DouDong-II
//
//  Created by Jobs on 2020/12/27.
//

#import "DDInvitationVC.h"
#import "DDCollectionViewCell_Style2+GKPhotoBrowserDelegate.h"

DDInvitationVC *invitationVC;

@interface DDInvitationVC ()
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
@property(nonatomic,strong)NSMutableArray <DDInvitationModel *>*dataMutArr;
@property(nonatomic,strong)SaveImageModel *__block saveImageModel;

@end

@implementation DDInvitationVC

-(void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

-(void)loadView{
    [super loadView];
    invitationVC = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.setupNavigationBarHidden = YES;
    self.collectionView.alpha = 1;
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
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DDInvitationModel *invitationModel = self.dataMutArr[indexPath.row];
    
    if (invitationModel.imageArr.count || ![NSString isNullString:invitationModel.string]) {
        DDCollectionViewCell_Style2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDCollectionViewCell_Style2"
                                                                                      forIndexPath:indexPath];
        cell.idxPath = indexPath;
        [cell actionBlockCollectionViewCell_Style2:^(id data) {
            NSLog(@"点我干嘛");//关注、未关注 按钮点击事件
            if ([data isKindOfClass:DDCollectionViewCell_Style2.class]) {
                self.xl_pushTranstion = nil;
                self.xl_popTranstion = nil;
                invitationModel.style2Location = DDCollectionViewCell_Style2LocationUserDetail;
                [UIViewController comingFromVC:self
                                          toVC:DDUserDetailsVC.new
                                   comingStyle:ComingStyle_PUSH
                             presentationStyle:UIModalPresentationFullScreen//[UIDevice currentDevice].systemVersion.doubleValue >= 13.0 ? UIModalPresentationAutomatic : UIModalPresentationFullScreen
                                 requestParams:invitationModel
                      hidesBottomBarWhenPushed:YES
                                      animated:YES
                                       success:^(id data) {

                }];
            }else if ([data isKindOfClass:UIButton.class]){
                self.btn = (UIButton *)data;
                if ([NSString isNullString:self.btn.titleLabel.text]) {//关注&未关注按钮
                    if (self.btn.selected) {
                        
                        SYSAlertControllerConfig *config = SYSAlertControllerConfig.new;
                        config.title = @"是否取消对其关注？";
                        config.isSeparateStyle = YES;
                        config.btnTitleArr = @[@"确定",@"取消"];
                        config.alertBtnActionArr = @[@"unfollow",@""];
                        config.targetVC = self;
                        config.funcInWhere = self;
                        config.animated = YES;
                        
                        [NSObject showSYSAlertViewConfig:config
                                            alertVCBlock:nil
                                         completionBlock:nil];
                    }else{
                        //关注
                        self.btn.selected = !self.btn.selected;
                    }
                }
            }else if ([data isKindOfClass:SaveImageModel.class]){
                self.saveImageModel = (SaveImageModel *)data;
                
                SYSAlertControllerConfig *config = SYSAlertControllerConfig.new;
                config.isSeparateStyle = YES;
                config.btnTitleArr = @[@"保存图片",@"取消"];
                config.alertBtnActionArr = @[@"savePic",@"nil"];
                config.targetVC = self.saveImageModel.photoBrowser;
                config.funcInWhere = self;
                config.animated = YES;
                
                [NSObject showSYSActionSheetConfig:config
                                      alertVCBlock:nil
                                   completionBlock:nil];
                
            }else{}
        }];
        [cell richElementsInCellWithModel:invitationModel];
        return cell;
    }else if (![NSString isNullString:invitationModel.adUrlStr]){
        DDCollectionViewCell_Style4 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDCollectionViewCell_Style4"
                                                                                      forIndexPath:indexPath];
        cell.idxPath = indexPath;
        [cell actionBlockCollectionViewCell_Style4:^(id data) {
            NSLog(@"点我干嘛");
        }];
        [cell richElementsInCellWithModel:invitationModel];
        return cell;
    }else if (![NSString isNullString:invitationModel.playerUrlStr]){
        DDCollectionViewCell_Style5 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDCollectionViewCell_Style5"
                                                                                      forIndexPath:indexPath];
        cell.idxPath = indexPath;
        [cell actionBlockCollectionViewCell_Style5:^(id data) {
            NSLog(@"点我干嘛");
        }];
        [cell richElementsInCellWithModel:invitationModel];
        return cell;
    }else{
        return UICollectionViewCell.new;
    }
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.dataMutArr.count;
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
    
    DDInvitationModel *invitationModel = self.dataMutArr[indexPath.row];
    
    if (invitationModel.imageArr || ![NSString isNullString:invitationModel.string]) {
        return [DDCollectionViewCell_Style2 cellSizeWithModel:invitationModel];
    }else if (![NSString isNullString:invitationModel.adUrlStr]){
        return [DDCollectionViewCell_Style4 cellSizeWithModel:invitationModel];
    }else if (![NSString isNullString:invitationModel.playerUrlStr]){
        return [DDCollectionViewCell_Style5 cellSizeWithModel:invitationModel];
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
        
        [_collectionView registerCollectionViewClass];

        [self.scrollView addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }return _collectionView;
}

-(UIColor *)bgCor{
    if (!_bgCor) {
        _bgCor = RGB_SAMECOLOR(246);
    }return _bgCor;
}

-(NSMutableArray<DDInvitationModel *> *)dataMutArr{
    if (!_dataMutArr) {
        _dataMutArr = NSMutableArray.array;
        
        {
            DDInvitationModel *model1 = DDInvitationModel.new;
            model1.string = @"她与我以前的同一公司的同时，说来也怪,在他结婚前,我对他差不多没有多少感觉，由此我们还因为工作的事情大吵一架，虽然她不是长得很漂亮…";
            model1.imageArr = @[KIMG(@"帖子占位图"),KIMG(@"帖子占位图"),KIMG(@"帖子占位图"),KIMG(@"帖子占位图")];
            model1.style2Location = DDCollectionViewCell_Style2LocationUsersList;

            DDCollectionViewCell_Style2TBVCellModel *commentModel1 = DDCollectionViewCell_Style2TBVCellModel.new;
            commentModel1.userHeaderIMG = KIMG(@"帖子占位图");//发帖用户头像
            commentModel1.usernameStr = @"王美丽";//发帖用户名
            commentModel1.postTimeStr = @"2020.1.6";//发帖时间
            commentModel1.postContentStr = @"可以约吗？";//发帖内容
            
            DDCollectionViewCell_Style2TBVCellModel *commentModel2 = DDCollectionViewCell_Style2TBVCellModel.new;
            commentModel2.userHeaderIMG = KIMG(@"帖子占位图");//发帖用户头像
            commentModel2.usernameStr = @"玩耍";//发帖用户名
            commentModel2.postTimeStr = @"2020.1.7";//发帖时间
            commentModel2.postContentStr = @"你好美,的解耦何地偶尔我给IG低谷IP的各位hiU豆debwuijhdpqigdqwghdiuoqhd89qdghdwhiodhwqudhqw9h9qwuhoishodxdbeijgwihgdqwhdqwdbkjhdqowihdqow0ihdqwo？";//发帖内容
            
            DDCollectionViewCell_Style2TBVCellModel *commentModel3 = DDCollectionViewCell_Style2TBVCellModel.new;
            commentModel3.userHeaderIMG = KIMG(@"帖子占位图");//发帖用户头像
            commentModel3.usernameStr = @"夜店之美";//发帖用户名
            commentModel3.postTimeStr = @"2020.1.8";//发帖时间
            commentModel3.postContentStr = @"交个朋友？";//发帖内容
            
            DDCollectionViewCell_Style2TBVCellModel *commentModel4 = DDCollectionViewCell_Style2TBVCellModel.new;
            commentModel4.userHeaderIMG = KIMG(@"帖子占位图");//发帖用户头像
            commentModel4.usernameStr = @"成人之花";//发帖用户名
            commentModel4.postTimeStr = @"2020.1.9";//发帖时间
            commentModel4.postContentStr = @"好酥服？";//发帖内容
            NSMutableArray *dataMutArr = NSMutableArray.array;
            [dataMutArr addObject:commentModel1];
            [dataMutArr addObject:commentModel2];
            [dataMutArr addObject:commentModel3];
            [dataMutArr addObject:commentModel4];
            model1.commentModelArr = (NSArray *)dataMutArr;
            
            [_dataMutArr addObject:model1];
        }//model1
        
        {
            DDInvitationModel *model2 = DDInvitationModel.new;
            model2.imageArr = @[KIMG(@"帖子占位图"),KIMG(@"帖子占位图"),KIMG(@"帖子占位图"),KIMG(@"帖子占位图")];
            model2.style2Location = DDCollectionViewCell_Style2LocationUsersList;
            [_dataMutArr addObject:model2];
        }//model2

        {
            DDInvitationModel *model3 = DDInvitationModel.new;
            model3.string = @"她与我以前的同一公司的同时，说来也怪,在他结婚前,我对他差不多没有多少感觉，由此我们还因为工作的事情大吵一架，虽然她不是长得很漂亮…";
            model3.style2Location = DDCollectionViewCell_Style2LocationUsersList;
            [_dataMutArr addObject:model3];
        }//model3

        {
            DDInvitationModel *model4 = DDInvitationModel.new;
            model4.playerUrlStr = @"播放地址";
            model4.style2Location = DDCollectionViewCell_Style2LocationUsersList;
            [_dataMutArr addObject:model4];
        }//model4
        
        {
            DDInvitationModel *model5 = DDInvitationModel.new;
            model5.adUrlStr = @"广告地址";
            model5.style2Location = DDCollectionViewCell_Style2LocationUsersList;
            [_dataMutArr addObject:model5];
        }//model5 
    }return _dataMutArr;
}

@end
