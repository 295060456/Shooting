//
//  DDCollectionViewCell_Style2.m
//  DouDong-II
//
//  Created by Jobs on 2020/12/26.
//

#import "DDCollectionViewCell_Style2.h"
#import "DDCollectionViewCell_Style2+GKPhotoBrowserDelegate.h"
#import "DDCollectionViewCell_Style2+UICollectionViewDataSource.h"
#import "DDCollectionViewCell_Style2+UICollectionViewDelegate.h"
#import "DDCollectionViewCell_Style2+UICollectionViewDelegateFlowLayout.h"
#import "DDCollectionViewCell_Style2+UITableViewDataSource.h"
#import "DDCollectionViewCell_Style2+UITableViewDelegate.h"

static CGFloat offset = 20;//高度补偿值

@interface DDCollectionViewCell_Style2 ()

//UI
@property(nonatomic,strong)UIImageView *userHeaderIMGV;
@property(nonatomic,strong)UILabel *usernameLab;
@property(nonatomic,strong)UIButton *attentionBtn;
@property(nonatomic,strong)UILabel *contentTextLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UIButton *likeBtn;
@property(nonatomic,strong)UIButton *remarkBtn;
@property(nonatomic,strong)UICollectionViewFlowLayout *layout;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UITableView *tableView;
//data
@property(nonatomic,assign)CGFloat contentTextLabHeight;
@property(nonatomic,assign)CGFloat collectionViewHeight;
@property(nonatomic,assign)CGFloat commentHeight;

@end

@implementation DDCollectionViewCell_Style2

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
//        [UIView makeTargetShadowview:self
//                           superView:nil
//                     shadowDirection:ShadowDirection_rightDown
//                   shadowWithOffsetX:5
//                             offsetY:5
//                        cornerRadius:10
//                        shadowOffset:defaultSize
//                       shadowOpacity:0.5
//                    layerShadowColor:defaultObj
//                   layerShadowRadius:defaultValue];
        self.backgroundColor = kWhiteColor;
        [UIView cornerCutToCircleWithView:self
                          andCornerRadius:6];
    }return self;
}

-(void)actionBlockCollectionViewCell_Style2:(MKDataBlock)collectionViewCell_Style2Block{
    self.collectionViewCell_Style2Block = collectionViewCell_Style2Block;
}

-(void)richElementsInCellWithModel:(DDInvitationModel *_Nullable)model{
    self.invitationModel = model;// 用 invitationModel
    self.contentView.backgroundColor = kWhiteColor;
    self.userHeaderIMGV.image = KIMG(@"UserDefaultIcon");
    self.usernameLab.text = @"小甜甜";
    [self.usernameLab sizeToFit];
    
    if (![NSString isNullString:model.string]) {
        self.contentTextLab.text = model.string;
    }
    self.attentionBtn.alpha = 1;
    
    if (model.imageArr.count) {
        
        int row = ceilf(model.imageArr.count / 3.0);
        self.collectionViewHeight = [DDCollectionViewCell_Style3 cellSizeWithModel:nil].height * row + offset;
        self.collectionView.alpha = 1;
    }
    
    if (model.commentModelArr.count) {
        self.tableView.alpha = 1;
    }
    
    [self.likeBtn setTitle:@"233"
                  forState:UIControlStateNormal];
    [self.likeBtn setImage:KIMG(@"帖子未点赞")
                  forState:UIControlStateNormal];
    [self.likeBtn setImage:KIMG(@"帖子已点赞")
                  forState:UIControlStateSelected];

    self.timeLab.text = @"2小时前";
    [self.timeLab sizeToFit];
    
    [self.remarkBtn setTitle:@"23"
                    forState:UIControlStateNormal];
    [self.remarkBtn setImage:KIMG(@"帖子评论")
                    forState:UIControlStateNormal];
    
    [self.likeBtn.titleLabel sizeToFit];
    [self.likeBtn.titleLabel adjustsFontSizeToFitWidth];
    
    [self.remarkBtn.titleLabel sizeToFit];
    [self.remarkBtn.titleLabel adjustsFontSizeToFitWidth];
}

+(CGSize)cellSizeWithModel:(DDInvitationModel * _Nullable)model{
    //固定的偏移量
    CGFloat fix = 29 + 5 * 2 + 12 + 17;
    //图区域高度
    CGFloat collectionViewHeight = 0;
    if (model.imageArr.count) {
        int row = ceilf(model.imageArr.count / 3.0);
        collectionViewHeight = [DDCollectionViewCell_Style3 cellSizeWithModel:nil].height * row + offset;
    }
    //文字区域高度
    CGFloat contentTextHeight = 0;
    if (![NSString isNullString:model.string]) {
        contentTextHeight = [NSString getContentHeightOrWidthWithParagraphStyleLineSpacing:1
                                                                     calcLabelHeight_Width:CalcLabelHeight
                                                                              effectString:model.string
                                                                                      font:[UIFont systemFontOfSize:12
                                                                                                             weight:UIFontWeightRegular]
                                                              boundingRectWithHeight_Width:SCREEN_WIDTH - (10 + 15) * 2];
    }
    //评论区域高度
    CGFloat commentHeight = 0;
    switch (model.style2Location) {
        case DDCollectionViewCell_Style2LocationUsersList:{
            if (model.commentModelArr.count >= 3) {
                for (int d = 0; d < 3; d++) {//外层最多展示3条
                    DDCollectionViewCell_Style2TBVCellModel *style2TBVCellModel = model.commentModelArr[d];
                    commentHeight += [DDCollectionViewCell_Style2TBVCell cellHeightWithModel:style2TBVCellModel];
                }
            }else{
                for (DDCollectionViewCell_Style2TBVCellModel *style2TBVCellModel in model.commentModelArr) {
                    commentHeight += [DDCollectionViewCell_Style2TBVCell cellHeightWithModel:style2TBVCellModel];
                }
            }
        }break;
        case DDCollectionViewCell_Style2LocationUserDetail:{
            for (DDCollectionViewCell_Style2TBVCellModel *style2TBVCellModel in model.commentModelArr) {
                commentHeight += [DDCollectionViewCell_Style2TBVCell cellHeightWithModel:style2TBVCellModel];
            }
        }break;
        default:
            break;
    }
    //补偿值
    CGFloat offset = 15;
    
    CGFloat height = fix + contentTextHeight + collectionViewHeight + commentHeight + offset;
    return CGSizeMake(SCREEN_WIDTH - 10 * 2, height);
}

-(void)skipToUserDetail{
    NSLog(@"");
    if (self.collectionViewCell_Style2Block) {
        self.collectionViewCell_Style2Block(self);
    }
}
#pragma mark —— lazyLoad
-(UIImageView *)userHeaderIMGV{
    if (!_userHeaderIMGV) {
        _userHeaderIMGV = UIImageView.new;
        {
            _userHeaderIMGV.userInteractionEnabled = YES;
            _userHeaderIMGV.target = self;//这句很关键
            _userHeaderIMGV.numberOfTouchesRequired = 1;
            _userHeaderIMGV.numberOfTapsRequired = 1;
            _userHeaderIMGV.tapGR.enabled = YES;
            
    //        @weakify(self)
            _userHeaderIMGV.callbackBlock = ^(id weakSelf, id arg, UIGestureRecognizer *data3) {
    //            @strongify(self)
                [weakSelf skipToUserDetail];
            };
        }
        [self.contentView addSubview:_userHeaderIMGV];
        [_userHeaderIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(29, 29));
            make.top.equalTo(self.contentView).offset(7);
            make.left.equalTo(self.contentView).offset(16);
        }];
        [UIView cornerCutToCircleWithView:_userHeaderIMGV
                          andCornerRadius:29 / 2];
    }return _userHeaderIMGV;
}

-(UILabel *)usernameLab{
    if (!_usernameLab) {
        _usernameLab = UILabel.new;
        _usernameLab.textColor = kBlackColor;
        _usernameLab.textAlignment = NSTextAlignmentCenter;
        _usernameLab.font = [UIFont systemFontOfSize:13
                                              weight:UIFontWeightMedium];
        [self.contentView addSubview:_usernameLab];
        [_usernameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.userHeaderIMGV);
            make.left.equalTo(self.userHeaderIMGV.mas_right).offset(9);
        }];
    }return _usernameLab;
}

-(UIButton *)attentionBtn{
    if (!_attentionBtn) {
        _attentionBtn = UIButton.new;
        [_attentionBtn setImage:KIMG(@"关注按钮")
                       forState:UIControlStateNormal];
        [_attentionBtn setImage:KIMG(@"已关注按钮")
                       forState:UIControlStateSelected];
        @weakify(self)
        [[_attentionBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            if (self.collectionViewCell_Style2Block) {
                self.collectionViewCell_Style2Block(x);
            }
        }];
        [self.contentView addSubview:_attentionBtn];
        [_attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(45, 21));
            make.bottom.equalTo(self.userHeaderIMGV);
            make.right.equalTo(self.contentView).offset(-13);
        }];
        [self layoutIfNeeded];
        [UIView cornerCutToCircleWithView:_attentionBtn
                          andCornerRadius:_attentionBtn.height / 2];
    }return _attentionBtn;
}

-(UILabel *)contentTextLab{
    if (!_contentTextLab) {
        _contentTextLab = UILabel.new;
        _contentTextLab.font = [UIFont systemFontOfSize:12
                                                 weight:UIFontWeightRegular];
        switch (self.invitationModel.style2MsgType) {
            case CollectionViewCell_Style2MsgType_1:{
                _contentTextLab.numberOfLines = 3;
            }break;
            case CollectionViewCell_Style2MsgType_2:{
                _contentTextLab.numberOfLines = 0;
            }break;
            default:
                break;
        }
        _contentTextLab.textColor = kBlackColor;
        _contentTextLab.font = [UIFont systemFontOfSize:12
                                                 weight:UIFontWeightRegular];
        [self.contentView addSubview:_contentTextLab];
        [_contentTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
            make.top.equalTo(self.userHeaderIMGV.mas_bottom).offset(10);
            switch (self.invitationModel.style2MsgType) {
                case CollectionViewCell_Style2MsgType_1:{
                    
                }break;
                case CollectionViewCell_Style2MsgType_2:{
                    make.height.mas_equalTo(self.contentTextLabHeight);
                }break;
                default:
                    break;
            }
        }];
    }return _contentTextLab;
}

-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = UILabel.new;
        _timeLab.textColor = KLightGrayColor;
        _timeLab.font = [UIFont systemFontOfSize:10
                                          weight:UIFontWeightRegular];
        [self.contentView addSubview:_timeLab];
        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            if (_tableView) {
                make.top.equalTo(self.tableView.mas_bottom).offset(5);
            }else{
                make.top.equalTo(self.collectionView.mas_bottom).offset(5);
            }
            make.left.equalTo(self.contentTextLab);
        }];
    }return _timeLab;
}

-(UIButton *)likeBtn{
    if (!_likeBtn) {
        _likeBtn = UIButton.new;
        _likeBtn.titleLabel.font = [UIFont systemFontOfSize:9
                                                     weight:UIFontWeightLight];
        [_likeBtn setTitleColor:KLightGrayColor
                       forState:UIControlStateNormal];
        @weakify(self)
        [[_likeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if (self.collectionViewCell_Style2Block) {
                self.collectionViewCell_Style2Block(x);
            }
            x.selected = !x.selected;
        }];
        [self.contentView addSubview:_likeBtn];
        [_likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.timeLab);
            make.right.equalTo(self.remarkBtn.mas_left).offset(-14.5);
        }];
    }return _likeBtn;
}

-(UIButton *)remarkBtn{
    if (!_remarkBtn) {
        _remarkBtn = UIButton.new;
        _remarkBtn.titleLabel.font = [UIFont systemFontOfSize:9
                                                       weight:UIFontWeightLight];
        [_remarkBtn setTitleColor:KLightGrayColor
                         forState:UIControlStateNormal];
        @weakify(self)
        [[_remarkBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if (self.collectionViewCell_Style2Block) {
                self.collectionViewCell_Style2Block(x);
            }
        }];
        [self.contentView addSubview:_remarkBtn];
        [_remarkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentTextLab);
            make.bottom.equalTo(self.timeLab);
        }];
    }return _remarkBtn;
}

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
        _collectionView.backgroundColor = kWhiteColor;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = NO;
        
        [_collectionView registerCollectionViewClass];

        [self.contentView addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentTextLab);
            make.top.equalTo(self.contentTextLab.mas_bottom).offset(8);
            make.height.mas_equalTo(self.collectionViewHeight);
        }];
    }return _collectionView;
}

-(NSMutableArray<GKPhoto *> *)photosMutArr{
    if (!_photosMutArr) {
        _photosMutArr = NSMutableArray.array;
    }return _photosMutArr;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.backgroundColor = HEXCOLOR(0xFAFAFA);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = UIView.new;
        _tableView.tableFooterView.backgroundColor = kWhiteColor;
        [self.contentView addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.collectionView.mas_bottom).offset(5);
            make.left.right.equalTo(self.collectionView);
            make.bottom.equalTo(self.contentView).offset(-25);
        }];
        [UIView cornerCutToCircleWithView:_tableView andCornerRadius:6];
    }return _tableView;
}

@end
