//
//  FindCodeFlowChartView.m
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "FindCodeFlowChartView.h"

@interface FlowChartSingleElementView ()

@property(nonatomic,strong)UIImageView *backIMGV;

@end

@implementation FlowChartSingleElementView

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    self.backIMGV.alpha = 1;
    self.titleLab.alpha = 1;
    self.subTitleLab.alpha = 1;
}

#pragma mark —— lazyLoad
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.font = [UIFont systemFontOfSize:20 weight:UIFontWeightHeavy];
        [_titleLab sizeToFit];
        [self.backIMGV addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.backIMGV);
            make.bottom.equalTo(self.backIMGV.mas_centerY).offset(7);
        }];
    }return _titleLab;
}

-(UILabel *)subTitleLab{
    if (!_subTitleLab) {
        _subTitleLab = UILabel.new;
        _subTitleLab.font = [UIFont systemFontOfSize:8 weight:UIFontWeightRegular];
        [_subTitleLab sizeToFit];
        [self.backIMGV addSubview:_subTitleLab];
        [_subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.backIMGV);
            make.top.equalTo(self.backIMGV.mas_centerY).offset(7);
        }];
    }return _subTitleLab;
}

-(UIImageView *)backIMGV{
    if (!_backIMGV) {
        _backIMGV = UIImageView.new;
        _backIMGV.image = kIMG(@"di_1");
        [self addSubview:_backIMGV];
        [_backIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }return _backIMGV;
}

@end

@interface FindCodeFlowChartView ()

@property(nonatomic,strong)NSMutableArray <FlowChartSingleElementView *>*singleElementMutArr;
@property(nonatomic,assign)BOOL isOK;//保证 makeFlowChart 只创建一次

@end

@implementation FindCodeFlowChartView

-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        [self makeFlowChart];
    }
}

-(void)makeFlowChart{
    if (self.flowNum) {
        //单个节点的高度
//        CGFloat singleElementH = self.mj_h;
        //每个节点的宽度
        CGFloat singleElementW = SCREEN_WIDTH / self.flowNum;
        for (int t = 0; t < self.flowNum; t++) {
            FlowChartSingleElementView *singleElement = FlowChartSingleElementView.new;
            singleElement.titleLab.text = self.titleMutArr[t];
            singleElement.subTitleLab.text = self.subTitleMutArr[t];
            [self addSubview:singleElement];
            [singleElement mas_makeConstraints:^(MASConstraintMaker *make) {
                [singleElement mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(singleElementW);
                    make.top.bottom.equalTo(self);
                    if (t == 0) {//第一个元素，从左边开始布局
                        make.left.equalTo(self);
                    }else{
                        FlowChartSingleElementView *lastSingleElement = self.singleElementMutArr[t - 1];
                        make.left.equalTo(lastSingleElement.mas_right);
                    }
                }];
                [self.singleElementMutArr addObject:singleElement];
            }];
        }
    }
    
    if (self.singleElementMutArr.count) {
        self.isOK = YES;
    }
}

#pragma mark —— lazyLoad
-(NSMutableArray<FlowChartSingleElementView *> *)singleElementMutArr{
    if (!_singleElementMutArr) {
        _singleElementMutArr = NSMutableArray.array;
    }return _singleElementMutArr;
}


@end
