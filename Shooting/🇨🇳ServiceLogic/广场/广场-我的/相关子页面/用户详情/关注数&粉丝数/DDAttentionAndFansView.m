//
//  DDAttentionAndFansView.m
//  DouDong-II
//
//  Created by Jobs on 2021/1/5.
//

#import "DDAttentionAndFansView.h"

@interface DDAttentionAndFansView ()
// UI
@property(nonatomic,strong)TwoVerticalArrangementLabsView *labsView_1;
@property(nonatomic,strong)TwoVerticalArrangementLabsView *labsView_2;
@property(nonatomic,strong)UILabel *verticalLineLab;
// Data
@property(nonatomic,copy)MKDataBlock attentionAndFansViewBlock;
@property(nonatomic,strong)LabsModel *model_1;
@property(nonatomic,strong)LabsModel *model_2;

@end

@implementation DDAttentionAndFansView

-(void)richElementsInCellWithModel:(id _Nullable)model{
    self.labsView_1.alpha = 1;
    self.labsView_2.alpha = 1;
    self.verticalLineLab.alpha = 1;
    [UIView cornerCutToCircleWithView:self andCornerRadius:8];
}

-(void)actionBlockAttentionAndFansView:(MKDataBlock)attentionAndFansViewBlock{
    self.attentionAndFansViewBlock = attentionAndFansViewBlock;
}
//我关注的
-(void)IFocusOn{
    if (self.attentionAndFansViewBlock) {
        self.attentionAndFansViewBlock(@"IFocusOn");
    }
}
//关注我的
-(void)payAttentionToMe{
    if (self.attentionAndFansViewBlock) {
        self.attentionAndFansViewBlock(@"payAttentionToMe");
    }
}
#pragma mark —— lazyLoad
-(TwoVerticalArrangementLabsView *)labsView_1{
    if (!_labsView_1) {
        _labsView_1 = TwoVerticalArrangementLabsView.new;
        
        {// A
            _labsView_1.userInteractionEnabled = YES;
            _labsView_1.target = self;
            _labsView_1.numberOfTouchesRequired = 1;
            _labsView_1.numberOfTapsRequired = 1;
            _labsView_1.tapGR.enabled = YES;
//            @weakify(self)
            _labsView_1.callbackBlock = ^(id weakSelf, id arg, UIGestureRecognizer *data3) {
//                @strongify(self)
                [weakSelf IFocusOn];
            };
        }
        
        [_labsView_1 richElementsInCellWithModel:self.model_1];
        [self addSubview:_labsView_1];
        [_labsView_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(65);
        }];
    }return _labsView_1;
}

-(TwoVerticalArrangementLabsView *)labsView_2{
    if (!_labsView_2) {
        _labsView_2 = TwoVerticalArrangementLabsView.new;
        {// A
            _labsView_2.userInteractionEnabled = YES;
            _labsView_2.target = self;
            _labsView_2.numberOfTouchesRequired = 1;
            _labsView_2.numberOfTapsRequired = 1;
            _labsView_2.tapGR.enabled = YES;
            
//            @weakify(self)
            _labsView_2.callbackBlock = ^(id weakSelf, id arg, UIGestureRecognizer *data3) {
//                @strongify(self)
                [weakSelf payAttentionToMe];
            };
        }
        [_labsView_2 richElementsInCellWithModel:self.model_2];
        [self addSubview:_labsView_2];
        [_labsView_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-65);
        }];
    }return _labsView_2;
}

-(UILabel *)verticalLineLab{
    if (!_verticalLineLab) {
        _verticalLineLab = UILabel.new;
        _verticalLineLab.backgroundColor = KLightGrayColor;
        [self addSubview:_verticalLineLab];
        [_verticalLineLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(1, 20));
            make.center.equalTo(self);
        }];
    }return _verticalLineLab;
}

-(LabsModel *)model_1{
    if (!_model_1) {
        _model_1 = LabsModel.new;
        _model_1.topLabTitleStr = @"12";
        _model_1.bottomLabTitleStr = @"关注数";
    }return _model_1;
}

-(LabsModel *)model_2{
    if (!_model_2) {
        _model_2 = LabsModel.new;
        _model_2.topLabTitleStr = @"2.1万";
        _model_2.bottomLabTitleStr = @"粉丝数";
    }return _model_2;
}

@end
