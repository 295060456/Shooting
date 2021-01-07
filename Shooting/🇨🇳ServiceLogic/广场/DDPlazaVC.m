//
//  DDPlazaVC.m
//  DouDong-II
//
//  Created by Jobs on 2020/12/16.
//

#import "DDPlazaVC.h"

static const NSInteger DefaultShow = 1;//默认显示第几号

@interface DDPlazaVC ()
<
JXCategoryViewDelegate
,JXCategoryListContainerViewDelegate
>

@property(nonatomic,strong)JXCategoryDotView *categoryTitleView;
@property(nonatomic,strong)JXCategoryIndicatorBackgroundView *backgroundView;
@property(nonatomic,strong)JXCategoryListContainerView *listContainerView;
@property(nonatomic,strong)UIImageView *bgimgV;
@property(nonatomic,strong)SuspendBtn *postBtn;//发帖

@property(nonatomic,strong)NSMutableArray <NSString *> *headerTitles;
@property(nonatomic,strong)NSMutableArray <UIViewController *>*childVCsMutArr;
@property(nonatomic,strong)NSMutableArray <NSNumber *>*dotStatesMutArr;

@end

@implementation DDPlazaVC

-(void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

-(void)loadView{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.setupNavigationBarHidden = YES;
    self.categoryTitleView.alpha = 1;
    self.bgimgV.alpha = 1;
    self.postBtn.alpha = 1;
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
#pragma mark - JXCategoryViewDelegate
-(void)categoryView:(JXCategoryBaseView *)categoryView
didSelectedItemAtIndex:(NSInteger)index {//终值
    [self.listContainerView didClickSelectedItemAtIndex:index];
    //点击以后红点消除
    if ([self.dotStatesMutArr[index] boolValue]) {
        self.dotStatesMutArr[index] = @(NO);
        self.categoryTitleView.dotStates = self.dotStatesMutArr;
        [categoryView reloadCellAtIndex:index];
    }
}
#pragma mark - JXCategoryListContainerViewDelegate
-(id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView
                                         initListForIndex:(NSInteger)index{
    return self.childVCsMutArr[index];
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.headerTitles.count;
}
#pragma mark —— lazyLoad
-(JXCategoryDotView *)categoryTitleView{
    if (!_categoryTitleView) {
        _categoryTitleView = JXCategoryDotView.new;
        _categoryTitleView.width = 180;
        _categoryTitleView.height = categoryTitleViewHeight;
        _categoryTitleView.y = Top() - NavigationHeight() + 18;
        _categoryTitleView.backgroundColor = kClearColor;
        _categoryTitleView.dotSize = CGSizeMake(5, 5);
        _categoryTitleView.titles = self.headerTitles;
        _categoryTitleView.indicators = @[self.backgroundView];
        _categoryTitleView.delegate = self;
        _categoryTitleView.dotStates = self.dotStatesMutArr;
        _categoryTitleView.titleSelectedColor = kWhiteColor;
        _categoryTitleView.titleColor = kBlackColor;
        _categoryTitleView.cellWidthIncrement = 10;
        _categoryTitleView.titleFont = [UIFont systemFontOfSize:20//14.75
                                                         weight:UIFontWeightMedium];
        _categoryTitleView.listContainer =  self.listContainerView;
        _categoryTitleView.defaultSelectedIndex = DefaultShow;//默认从第二个开始显示
        _categoryTitleView.titleColorGradientEnabled = YES;
        _categoryTitleView.titleLabelZoomEnabled = YES;
        [self.view addSubview:_categoryTitleView];
    }return _categoryTitleView;
}

- (JXCategoryListContainerView *)listContainerView {
    if (!_listContainerView) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView
                                                                      delegate:self];
//        _listContainerView.backgroundColor = kRedColor;
        [self.view addSubview:_listContainerView];
        [_listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(categoryTitleViewHeight);
            make.left.right.bottom.equalTo(self.view);
        }];
    }return _listContainerView;
}

-(JXCategoryIndicatorBackgroundView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = JXCategoryIndicatorBackgroundView.new;
        _backgroundView.indicatorHeight = 30;
        _backgroundView.indicatorCornerRadius = 0;
        _backgroundView.indicatorColor = kClearColor;
    }return _backgroundView;
}

-(UIImageView *)bgimgV{
    if (!_bgimgV) {
        _bgimgV = UIImageView.new;
        _bgimgV.image = KIMG(@"背景样式1");
        [self.backgroundView addSubview:_bgimgV];
        [_bgimgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.backgroundView);
        }];
    }return _bgimgV;
}

-(SuspendBtn *)postBtn{
    if (!_postBtn) {
        _postBtn = SuspendBtn.new;
        _postBtn.backgroundColor = kClearColor;
        [_postBtn setImage:KIMG(@"编辑")
                  forState:UIControlStateNormal];
        _postBtn.isAllowDrag = NO;//悬浮效果必须要的参数
        @weakify(self)
        self.view.vc = weak_self;
        [self.view addSubview:_postBtn];
        _postBtn.frame = CGRectMake(SCREEN_WIDTH - 43 - 34,
                                    SCREEN_HEIGHT - 84 - 34 - TabBarHeight() - BottomSafeAreaHeight(),
                                    34,
                                    34);
        [UIView cornerCutToCircleWithView:_postBtn
                          andCornerRadius:_postBtn.height / 2];
        [[_postBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof SuspendBtn * _Nullable x) {
            @strongify(self)
            self.xl_pushTranstion = [XLBubbleTransition transitionWithAnchorRect:x.frame];
            self.xl_popTranstion = [XLBubbleTransition transitionWithAnchorRect:x.frame];
            [UIViewController comingFromVC:self
                                      toVC:DDPostVC.new
                               comingStyle:ComingStyle_PUSH
                         presentationStyle:UIModalPresentationFullScreen//[UIDevice currentDevice].systemVersion.doubleValue >= 13.0 ? UIModalPresentationAutomatic : UIModalPresentationFullScreen
                             requestParams:nil
                  hidesBottomBarWhenPushed:YES
                                  animated:YES
                                   success:^(id data) {

            }];
        }];
    }return _postBtn;
}

-(NSMutableArray<NSNumber *> *)dotStatesMutArr{
    if (!_dotStatesMutArr) {
        _dotStatesMutArr = NSMutableArray.array;
        [_dotStatesMutArr addObject:@YES];
        [_dotStatesMutArr addObject:@NO];
    }return _dotStatesMutArr;
}

-(NSMutableArray<NSString *> *)headerTitles{
    if (!_headerTitles) {
        _headerTitles = NSMutableArray.array;
        [_headerTitles addObject:@"我的"];
        [_headerTitles addObject:@"社区"];
    }return _headerTitles;
}

-(NSMutableArray<UIViewController *> *)childVCsMutArr{
    if (!_childVCsMutArr) {
        _childVCsMutArr = NSMutableArray.array;
        [_childVCsMutArr addObject:DDPlazaMineVC.new];//广场-我的
        [_childVCsMutArr addObject:DDPlazaCommunityVC.new];//广场-社区
    }return _childVCsMutArr;
}

@end
