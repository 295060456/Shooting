//
//  DDFocusOnPeopleVC.m
//  DouDong-II
//
//  Created by Jobs on 2021/1/5.
//

#import "DDFocusOnPeopleVC.h"

@interface DDFocusOnPeopleVC ()
<
UITableViewDelegate
,UITableViewDataSource
>
// UI
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,weak)UIButton *btn;

@end

@implementation DDFocusOnPeopleVC

-(void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.setupNavigationBarHidden = YES;
    self.backBtnTitle = @"";
    
    if ([self.requestParams isKindOfClass:NSNumber.class]) {
        NSNumber *f = (NSNumber *)self.requestParams;
        switch (f.integerValue) {
            case FocusOnMe:{// 关注我的
                self.gk_navTitle = @"关注TA的人";
            }break;
            case FocusOnOthers:{// 我关注别人的
                self.gk_navTitle = @"TA关注的人";
            }break;
            default:
                self.gk_navTitle = @"";
                break;
        }
    }
    
    self.gk_navTitleColor = kBlackColor;
    self.gk_navTitleFont = [UIFont systemFontOfSize:18 weight:UIFontWeightRegular];
    self.gk_backStyle = GKNavigationBarBackStyleBlack;
    self.gk_navLeftBarButtonItem = self.backBtnCategoryItem;
    self.tableView.alpha = 1;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
// 取消关注
-(void)unfollow{
    self.btn.selected = !self.btn.selected;
}
#pragma mark —————————— UITableViewDelegate,UITableViewDataSource ——————————
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [DDFocusOnPeopleTBVCell cellHeightWithModel:Nil];
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DDFocusOnPeopleTBVCell *cell = [DDFocusOnPeopleTBVCell cellWithTableView:tableView];
    [cell richElementsInCellWithModel:nil];
    @weakify(self)
    [cell actionBlockFocusOnPeopleTBVCell:^(id data) {
        @strongify(self)
        if ([data isKindOfClass:UIButton.class]) {
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
        }
    }];return cell;
}
#pragma mark —— lazyLoad
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.backgroundColor =  HEXCOLOR(0xFAFAFA);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.mj_header = self.mjRefreshGifHeader;
        _tableView.mj_header.automaticallyChangeAlpha = YES;//根据拖拽比例自动切换透明度
        _tableView.mj_footer = self.mjRefreshAutoGifFooter;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.gk_navigationBar.mas_bottom);
            make.left.right.bottom.equalTo(self.view);
        }];
    }return _tableView;
}




@end
