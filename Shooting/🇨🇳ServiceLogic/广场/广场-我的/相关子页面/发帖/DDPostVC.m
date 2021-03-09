//
//  DDPostVC.m
//  DouDong-II
//
//  Created by Jobs on 2020/12/27.
//

#import "DDPostVC.h"

@interface DDPostVC (){
    CGFloat DDPostDelViewHeight;
}
// UI
@property(nonatomic,strong)UIButton *releaseBtn;
@property(nonatomic,strong)UIBarButtonItem *releaseBtnItem;
@property(nonatomic,strong)DDPostInputView *postInputView;//输入区域
@property(nonatomic,strong)UILabel *tipsLab;
@property(nonatomic,strong)HXPhotoView *postPhotoView;//展示选择的图片
@property(nonatomic,strong)HXPhotoManager *photoManager;//选取图片的数据管理类
@property(nonatomic,strong)DDPostDelView *postDelView;//长按拖动的删除区域
@property(nonatomic,assign)BOOL needDeleteItem;
// Data
@property(nonatomic,strong)NSString *__block inputDataString;
@property(nonatomic,strong)NSString *__block inputDataHistoryString;
@property(nonatomic,strong)NSArray <HXPhotoModel *>*historyPhotoDataArr;//与之相对应的是self.photoManager.afterSelectedArray

@end

@implementation DDPostVC

-(void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

-(void)loadView{
    [super loadView];
    DDPostDelViewHeight = BottomSafeAreaHeight() + 50;
    self.historyPhotoDataArr = [self.photoManager getLocalModelsInFileWithAddData:YES];
    if (![NSString isNullString:DDUserInfo.sharedInstance.postDraftURLStr]) {
        self.inputDataHistoryString = [FileFolderHandleTool filePath:DDUserInfo.sharedInstance.postDraftURLStr
                                                            fileType:TXT];
    }
    NSLog(@"%@",self.inputDataHistoryString);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.setupNavigationBarHidden = YES;
    self.gk_navRightBarButtonItem = self.releaseBtnItem;
    self.gk_backStyle = GKNavigationBarBackStyleBlack;
    self.gk_navTitle = @"发帖";
    self.gk_navTitleColor = kBlackColor;
    self.gk_navTitleFont = [UIFont systemFontOfSize:17.28
                                             weight:UIFontWeightRegular];
    [self hideNavLine];
    self.postInputView.alpha = 1;
    self.tipsLab.alpha = 1;
    self.postPhotoView.alpha = 1;
    self.postDelView.alpha = 1;
    [self releaseBtnState:self.historyPhotoDataArr
          inputDataString:self.inputDataHistoryString];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = RGB_SAMECOLOR(249);
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    NSLog(@"");
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"");
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)saveDoc{
    @weakify(self)
    hx_showAlert(self,
                 @"将此次编辑保留?",
                 nil,
                 @"不保留",
                 @"保留", ^{
        @strongify(self)
        //不保留
        [self.photoManager deleteLocalModelsInFile];
        [self back:nil];
    }, ^{
        //保留
        //保存文字
        if (![NSString isNullString:self.inputDataString]) {
            DDUserInfo.sharedInstance.postDraftURLStr = [NSObject saveData:self.inputDataString
                                                     withDocumentsChildDir:@"发帖草稿数据临时文件夹"
                                                              fileFullname:@"发帖草稿数据.txt"
                                                                     error:nil];
        }else{
            [FileFolderHandleTool cleanFilesWithPath:DDUserInfo.sharedInstance.postDraftURLStr];
        }
        [weak_self.view hx_showLoadingHUDText:nil];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            BOOL success = [weak_self.photoManager saveLocalModelsToFile];//保存图片
            dispatch_async(dispatch_get_main_queue(), ^{
                [weak_self.view hx_handleLoading];
                if (success) {
                    [weak_self back:nil];
                }else {
                    [weak_self.view hx_showImageHUDText:@"保存失败"];
                }
            });
        });
    });
}
/// 返回按钮点击方法 【覆写父类方法】 // 清空草稿   [self.photoManager deleteLocalModelsInFile];
- (void)backItemClick:(id)sender{
    if (![self.photoManager.afterSelectedArray compareEqualArrElement:self.historyPhotoDataArr] ||//!d
        ![NSString isEqualStrA:self.inputDataHistoryString strB:self.inputDataString]) {
        [self saveDoc];
    }else{
        [self back:sender];
    }
}

- (void)back:(id)sender{
    // 因为manager上个界面也持有了，并不会释放。所以手动清空一下已选的数据
    [self.photoManager clearSelectedList];
    [self backBtnClickEvent:sender];
}

-(void)releaseBtnState:(NSArray *)photoDataArr
       inputDataString:(NSString *)inputDataString{
    self.releaseBtn.enabled = photoDataArr.count || inputDataString.length;
    if (self.releaseBtn.enabled) {
        [self.releaseBtn setImage:KIMG(@"发布")
                         forState:UIControlStateNormal];
    }else{
        [self.releaseBtn setImage:KIMG(@"未发布")
                         forState:UIControlStateNormal];
    }
}
#pragma mark —— HXPhotoViewDelegate
// 在这里获取到点选的资料
- (void)photoView:(HXPhotoView *)photoView
   changeComplete:(NSArray<HXPhotoModel *> *)allList//self.photoManager.afterSelectedArray
           photos:(NSArray<HXPhotoModel *> *)photos
           videos:(NSArray<HXPhotoModel *> *)videos
         original:(BOOL)isOriginal{
    [self releaseBtnState:allList
          inputDataString:self.inputDataString];
}

- (void)photoView:(HXPhotoView *)photoView
      updateFrame:(CGRect)frame {
    @weakify(self)
    [UIView animateWithDuration:0.25
                     animations:^{
        @strongify(self)
        self.postDelView.y = SCREEN_HEIGHT - self->DDPostDelViewHeight;
    }];
}

- (void)photoView:(HXPhotoView *)photoView
currentDeleteModel:(HXPhotoModel *)model
     currentIndex:(NSInteger)index {
    // 删除的时候需要将草稿删除
    if (self.photoManager.localModels) {
        NSMutableArray *localModels = self.photoManager.localModels.mutableCopy;
        if ([self.photoManager.localModels containsObject:model]) {
            [localModels removeObject:model];
        }
        self.photoManager.localModels = localModels.copy;
    }
}

- (BOOL)photoViewShouldDeleteCurrentMoveItem:(HXPhotoView *)photoView
                           gestureRecognizer:(UILongPressGestureRecognizer *)longPgr
                                   indexPath:(NSIndexPath *)indexPath {
    return self.needDeleteItem;
}

- (void)photoView:(HXPhotoView *)photoView
gestureRecognizerBegan:(UILongPressGestureRecognizer *)longPgr
        indexPath:(NSIndexPath *)indexPath{
    @weakify(self)
    [UIView animateWithDuration:0.25
                     animations:^{
        @strongify(self)
        self.postDelView.y = SCREEN_HEIGHT - self->DDPostDelViewHeight;
    }];
}

- (void)photoView:(HXPhotoView *)photoView
gestureRecognizerChange:(UILongPressGestureRecognizer *)longPgr
        indexPath:(NSIndexPath *)indexPath {
    CGPoint point = [longPgr locationInView:self.view];
    [self.postDelView richElementsInCellWithModel:point.y >= self.postDelView.hx_y];
}

- (void)photoView:(HXPhotoView *)photoView
gestureRecognizerEnded:(UILongPressGestureRecognizer *)longPgr
        indexPath:(NSIndexPath *)indexPath {
    CGPoint point = [longPgr locationInView:self.view];
    if (point.y >= self.postDelView.y) {
        self.needDeleteItem = YES;
        [self.postPhotoView deleteModelWithIndex:indexPath.item];
    }else {
        self.needDeleteItem = NO;
    }
    @weakify(self)
    [UIView animateWithDuration:0.25
                     animations:^{
        @strongify(self)
        self.postDelView.y = SCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        @strongify(self)
        [self.postDelView richElementsInCellWithModel:NO];
    }];
}
#pragma mark —— lazyLoad
-(UIButton *)releaseBtn{
    if (!_releaseBtn) {
        _releaseBtn = UIButton.new;
        _releaseBtn.enabled = NO;
        [_releaseBtn setImage:KIMG(@"未发布")
                     forState:UIControlStateNormal];
        [_releaseBtn setTitleColor:kWhiteColor
                          forState:UIControlStateNormal];
        _releaseBtn.width = 38;
        _releaseBtn.height = 23;
        @weakify(self)
        [[_releaseBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
        }];
        [self.view addSubview:_releaseBtn];
        [UIView cornerCutToCircleWithView:_releaseBtn
                          andCornerRadius:_releaseBtn.height / 2];
    }return _releaseBtn;
}

-(UIBarButtonItem *)releaseBtnItem{
    if (!_releaseBtnItem) {
        _releaseBtnItem = [[UIBarButtonItem alloc] initWithCustomView:self.releaseBtn];
    }return _releaseBtnItem;
}

-(DDPostInputView *)postInputView{
    if (!_postInputView) {
        _postInputView = DDPostInputView.new;
        _postInputView.backgroundColor = kWhiteColor;
        @weakify(self)
        [_postInputView actionBlockDDPostInputView:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:NSString.class]) {
                self.inputDataString = (NSString *)data;
                NSLog(@"self.inputDataString = %@",self.inputDataString);
                [self releaseBtnState:self.photoManager.afterSelectedArray
                      inputDataString:self.inputDataString];
            }
        }];
        [_postInputView richElementsInCellWithModel:self.inputDataHistoryString];
        [self.view addSubview:_postInputView];
        [_postInputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.gk_navigationBar.mas_bottom).offset(10);
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(101);
        }];
    }return _postInputView;
}

-(UILabel *)tipsLab{
    if (!_tipsLab) {
        _tipsLab = UILabel.new;
        _tipsLab.textColor = HEXCOLOR(0xADADAD);
        _tipsLab.font = [UIFont systemFontOfSize:12
                                          weight:UIFontWeightMedium];
        _tipsLab.numberOfLines = 0;
        _tipsLab.text = @"1、内容不允许出现纯数字，英文字母；\n2、图片/视频(图片最多9张/仅上传一段视频，大小不超100M)。";
        [_tipsLab sizeToFit];
        [self.view addSubview:_tipsLab];
        [_tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(14);
            make.top.equalTo(self.postInputView.mas_bottom).offset(11);
        }];
        [self.view layoutIfNeeded];
    }return _tipsLab;
}

-(HXPhotoView *)postPhotoView{
    if (!_postPhotoView) {
        _postPhotoView = [HXPhotoView photoManager:self.photoManager];
        _postPhotoView.spacing = 5.f;
        _postPhotoView.delegate = self;
        _postPhotoView.deleteCellShowAlert = YES;
        _postPhotoView.outerCamera = YES;
        _postPhotoView.previewShowDeleteButton = YES;
        [self.view addSubview:_postPhotoView];
        _postPhotoView.frame = CGRectMake(0,
                                          self.tipsLab.y +
                                          self.tipsLab.height + 10,
                                          SCREEN_WIDTH, 200);
    }return _postPhotoView;
}

-(HXPhotoManager *)photoManager {
    if (!_photoManager) {
        _photoManager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
        _photoManager.configuration.localFileName = @"DouDongPhotoModels";// 设置保存的文件名称
        _photoManager.configuration.type = HXConfigurationTypeWXMoment;
        _photoManager.configuration.showOriginalBytes = YES;
        _photoManager.configuration.showOriginalBytesLoading = YES;
    }return _photoManager;
}

-(DDPostDelView *)postDelView{
    if (!_postDelView) {
        _postDelView = DDPostDelView.new;
        [self.view addSubview:_postDelView];
        _postDelView.frame = CGRectMake(0,
                                        SCREEN_HEIGHT,
                                        SCREEN_WIDTH,
                                        DDPostDelViewHeight);
    }return _postDelView;
}

@end
