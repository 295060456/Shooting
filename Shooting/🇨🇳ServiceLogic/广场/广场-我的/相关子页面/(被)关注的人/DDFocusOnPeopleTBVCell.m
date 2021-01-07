//
//  DDFocusOnPeopleTBVCell.m
//  DouDong-II
//
//  Created by Jobs on 2021/1/5.
//

#import "DDFocusOnPeopleTBVCell.h"

@interface DDFocusOnPeopleTBVCell ()

//UI
@property(nonatomic,strong)UIImageView *userHeaderIMGV;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *fansNumBtn;//粉丝数
@property(nonatomic,strong)UIButton *postNumBtn;//发表的帖子数
@property(nonatomic,strong)UIButton *attentionBtn;//关注按钮
//Data
@property(nonatomic,strong)id model;
@property(nonatomic,copy)MKDataBlock focusOnPeopleTBVCellBlock;

@end

@implementation DDFocusOnPeopleTBVCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    DDFocusOnPeopleTBVCell *cell = (DDFocusOnPeopleTBVCell *)[tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [[DDFocusOnPeopleTBVCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                             reuseIdentifier:ReuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }return cell;
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    self.model = model;
    self.userHeaderIMGV.alpha = 1;
    self.titleLab.alpha = 1;
    self.fansNumBtn.alpha = 1;
    self.postNumBtn.alpha = 1;
    self.attentionBtn.alpha = 1;
}

-(void)actionBlockFocusOnPeopleTBVCell:(MKDataBlock)focusOnPeopleTBVCellBlock{
    self.focusOnPeopleTBVCellBlock = focusOnPeopleTBVCellBlock;
}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return 77.25;
}
#pragma mark —— LazyLoad
-(UIImageView *)userHeaderIMGV{
    if (!_userHeaderIMGV) {
        _userHeaderIMGV = UIImageView.new;
        _userHeaderIMGV.image = KIMG(@"UserDefaultIcon");
        [self.contentView addSubview:_userHeaderIMGV];
        [_userHeaderIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(48, 48));
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView).offset(20);
        }];
        [UIView cornerCutToCircleWithView:_userHeaderIMGV
                          andCornerRadius:48 / 2];
    }return _userHeaderIMGV;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = @"搞笑王";
        _titleLab.font = [UIFont systemFontOfSize:15.36 weight:UIFontWeightRegular];
        [_titleLab sizeToFit];
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userHeaderIMGV);
            make.left.equalTo(self.userHeaderIMGV.mas_right).offset(10.6);
        }];
    }return _titleLab;
}

-(UIButton *)fansNumBtn{
    if (!_fansNumBtn) {
        _fansNumBtn = UIButton.new;
        [_fansNumBtn setImage:KIMG(@"粉丝数量")
                     forState:UIControlStateNormal];
        [_fansNumBtn setTitle:@"111"
                     forState:UIControlStateNormal];
        [_fansNumBtn setTitleColor:HEXCOLOR(0x8E8E92)
                          forState:UIControlStateNormal];
        @weakify(self)
        [[_fansNumBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            x.selected = !x.selected;
        }];
        [self.contentView addSubview:_fansNumBtn];
        [_fansNumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.userHeaderIMGV);
            make.left.equalTo(self.titleLab);
        }];
    }return _fansNumBtn;
}

-(UIButton *)postNumBtn{
    if (!_postNumBtn) {
        _postNumBtn = UIButton.new;
        [_postNumBtn setImage:KIMG(@"发帖数量")
                     forState:UIControlStateNormal];
        [_postNumBtn setTitle:@"3445"
                     forState:UIControlStateNormal];
        [_postNumBtn setTitleColor:HEXCOLOR(0x8E8E92)
                          forState:UIControlStateNormal];
        @weakify(self)
        [[_postNumBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            x.selected = !x.selected;
        }];
        [self.contentView addSubview:_postNumBtn];
        [_postNumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.fansNumBtn.mas_right).offset(20);
            make.bottom.equalTo(self.userHeaderIMGV);
        }];
    }return _postNumBtn;
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
            if (self.focusOnPeopleTBVCellBlock) {
                self.focusOnPeopleTBVCellBlock(x);
            }
        }];
        [self.contentView addSubview:_attentionBtn];
        [_attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.userHeaderIMGV);
            make.size.mas_equalTo(CGSizeMake(54.7, 25.9));
            make.right.equalTo(self.contentView).offset(-20);
        }];
    }return _attentionBtn;
}

@end
