//
//  DDPlazaMineVC.m
//  DouDong-II
//
//  Created by Jobs on 2020/12/26.
//

#import "DDPlazaMineVC.h"

static const NSInteger DefaultShow = 1;//默认显示第几号

@interface DDPlazaMineVC ()
<
JXCategoryViewDelegate
,JXCategoryListContainerViewDelegate
>
// UI
@property(nonatomic,strong)JXCategoryTitleBackgroundView *categoryTitleView;
@property(nonatomic,strong)JXCategoryListContainerView *listContainerView;
// Data
@property(nonatomic,strong)NSMutableArray <NSString *> *headerTitles;
@property(nonatomic,strong)NSMutableArray <UIViewController *>*childVCsMutArr;

@end

@implementation DDPlazaMineVC

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
-(JXCategoryTitleBackgroundView *)categoryTitleView{
    if (!_categoryTitleView) {
        _categoryTitleView = JXCategoryTitleBackgroundView.new;
        _categoryTitleView.width = SCREEN_WIDTH;
        _categoryTitleView.height = categoryTitleViewHeight - 10;
        _categoryTitleView.y = 43;
        _categoryTitleView.backgroundColor = kWhiteColor;
        _categoryTitleView.titles = self.headerTitles;
        _categoryTitleView.delegate = self;
        _categoryTitleView.titleSelectedColor = HEXCOLOR(0xF54B64);
        _categoryTitleView.titleColor = HEXCOLOR(0x999999);
        _categoryTitleView.titleSelectedColor = HEXCOLOR(0xF54B64);
        _categoryTitleView.titleFont = [UIFont systemFontOfSize:12.48
                                                         weight:UIFontWeightMedium];
        _categoryTitleView.titleSelectedFont = [UIFont systemFontOfSize:13
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
        [self.view addSubview:_listContainerView];
        [_listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(categoryTitleViewHeight + 10);
            make.left.right.bottom.equalTo(self.view);
        }];
    }return _listContainerView;
}

-(NSMutableArray<NSString *> *)headerTitles{
    if (!_headerTitles) {
        _headerTitles = NSMutableArray.array;
        [_headerTitles addObject:@"关注过的"];
        [_headerTitles addObject:@"点赞过的"];
        [_headerTitles addObject:@"评论过的"];
        [_headerTitles addObject:@"我的发布"];
    }return _headerTitles;
}

-(NSMutableArray<UIViewController *> *)childVCsMutArr{
    if (!_childVCsMutArr) {
        _childVCsMutArr = NSMutableArray.array;
        [_childVCsMutArr addObject:DDMyAttentedVC.new];//关注过的
        [_childVCsMutArr addObject:DDMyLikedVC.new];//点赞过的
        [_childVCsMutArr addObject:DDMyRemarkedVC.new];//我的评论
        [_childVCsMutArr addObject:DDMyReleasedVC.new];//我的发布
    }return _childVCsMutArr;
}

@end
