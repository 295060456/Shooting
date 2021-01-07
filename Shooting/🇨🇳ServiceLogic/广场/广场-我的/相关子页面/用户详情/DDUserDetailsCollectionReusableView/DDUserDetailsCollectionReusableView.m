//
//  DDUserDetailsCollectionReusableView.m
//  DouDong-II
//
//  Created by Jobs on 2021/1/4.
//

#import "DDUserDetailsCollectionReusableView.h"

@interface DDUserDetailsCollectionReusableView ()

// UI
@property(nonatomic,strong)UIImageView *backgroundIMGV;//背景图
@property(nonatomic,strong)UIImageView *userHeaderIMGV;//用户头像
@property(nonatomic,strong)UILabel *userNameLab;//用户名
@property(nonatomic,strong)UIButton *attentionBtn;//关注按钮
@property(nonatomic,strong)DDAttentionAndFansView *attentionAndFansView;

// Data
@property(nonatomic,copy)MKDataBlock userDetailsCollectionReusableViewBlock;

@end

@implementation DDUserDetailsCollectionReusableView

-(void)actionBlockUserDetailsCollectionReusableView:(MKDataBlock)userDetailsCollectionReusableViewBlock{
    self.userDetailsCollectionReusableViewBlock = userDetailsCollectionReusableViewBlock;
}

-(void)richElementsInCellWithModel:(NSString *_Nullable)model{
    self.userInteractionEnabled = YES;
    self.backgroundIMGV.alpha = 1;
    self.attentionAndFansView.alpha = 1;
    self.userHeaderIMGV.alpha = 1;
    self.userNameLab.text = @"gagag";
    [self.userNameLab sizeToFit];
    self.attentionBtn.alpha = 1;
}

+(CGSize)collectionReusableViewSizeWithModel:(id _Nullable)model{
    return CGSizeMake(SCREEN_WIDTH, 264);
}
//未完待续？？？
-(UIView *)hitTest:(CGPoint)point
         withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point
                        withEvent:event];
    if (!view) {
        //将坐标由当前视图发送到 指定视图 fromView是无法响应的范围小父视图
        CGPoint stationPoint = [self.attentionAndFansView convertPoint:point
                                                              fromView:self];
        if (CGRectContainsPoint(self.attentionAndFansView.bounds, stationPoint)){
            view = self.attentionAndFansView;
        }
//        NSLog(@"view = %@",view);
    }return view;
}
#pragma mark —— lazyLoad
-(UIImageView *)backgroundIMGV{
    if (!_backgroundIMGV) {
        _backgroundIMGV = UIImageView.new;
        _backgroundIMGV.userInteractionEnabled = YES;
        _backgroundIMGV.image = KIMG(@"用户详情背景");
        [self addSubview:_backgroundIMGV];
        _backgroundIMGV.frame = self.bounds;
//        [_backgroundIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self);
//        }];
    }return _backgroundIMGV;
}

-(DDAttentionAndFansView *)attentionAndFansView{
    if (!_attentionAndFansView) {
        _attentionAndFansView = DDAttentionAndFansView.new;
        _attentionAndFansView.backgroundColor = kWhiteColor;
//        _attentionAndFansView.ableRespose = YES;//??
        [_attentionAndFansView richElementsInCellWithModel:nil];
        @weakify(self)
        [_attentionAndFansView actionBlockAttentionAndFansView:^(id data) {
            @strongify(self)
            if (self.userDetailsCollectionReusableViewBlock) {
                self.userDetailsCollectionReusableViewBlock(data);
            }
        }];
        [self.backgroundIMGV addSubview:_attentionAndFansView];
        [_attentionAndFansView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 23 * 2, 58));
            make.bottom.equalTo(self).offset(58 / 4);
        }];
    }return _attentionAndFansView;
}

-(UIImageView *)userHeaderIMGV{
    if (!_userHeaderIMGV) {
        _userHeaderIMGV = UIImageView.new;
        _userHeaderIMGV.image = KIMG(@"UserDefaultIcon");
        [self.backgroundIMGV addSubview:_userHeaderIMGV];
        [_userHeaderIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(64, 64));
            make.left.equalTo(self.backgroundIMGV).offset(20);
            make.top.equalTo(self.backgroundIMGV).offset(87);
        }];
        [UIView cornerCutToCircleWithView:_userHeaderIMGV andCornerRadius:64 / 2];
    }return _userHeaderIMGV;
}

-(UILabel *)userNameLab{
    if (!_userNameLab) {
        _userNameLab = UILabel.new;
        _userNameLab.textColor = kWhiteColor;
        _userNameLab.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
        [self.backgroundIMGV addSubview:_userNameLab];
        [_userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.userHeaderIMGV);
            make.left.equalTo(self.userHeaderIMGV.mas_right).offset(11.6);
        }];
    }return _userNameLab;
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
            if (self.userDetailsCollectionReusableViewBlock) {
                self.userDetailsCollectionReusableViewBlock(x);
            }
        }];
        [self.backgroundIMGV addSubview:_attentionBtn];
        [_attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.userNameLab);
            make.size.mas_equalTo(CGSizeMake(54.7, 25.9));
            make.right.equalTo(self.backgroundIMGV).offset(-20);
        }];
    }return _attentionBtn;
}

@end
