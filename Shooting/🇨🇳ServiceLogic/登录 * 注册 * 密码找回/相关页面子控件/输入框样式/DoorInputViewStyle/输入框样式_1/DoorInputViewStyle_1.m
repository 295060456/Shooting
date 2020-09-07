//
//  DoorInputViewStyle_2.m
//  Shooting
//
//  Created by Jobs on 2020/9/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "DoorInputViewStyle_1.h"

@interface DoorInputViewStyle_1 ()
<
UITextFieldDelegate
,CJTextFieldDeleteDelegate
>

@property(nonatomic,strong)UILabel *titleLab;

@end

@implementation DoorInputViewStyle_1

-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (![NSString isNullString:self.titleStr]) {
        self.titleLab.text = self.titleStr;
    }
    self.tf.alpha = 1;
    self.countDownBtn.alpha = 1;
}
#pragma mark —— CJTextFieldDeleteDelegate
- (void)cjTextFieldDeleteBackward:(CJTextField *)textField{
    
}
#pragma mark —— UITextFieldDelegate
//询问委托人是否应该在指定的文本字段中开始编辑
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
//告诉委托人在指定的文本字段中开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField{

}
//询问委托人是否应在指定的文本字段中停止编辑
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
//告诉委托人对指定的文本字段停止编辑
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.tf isValidate:@""];
}
//告诉委托人对指定的文本字段停止编辑
//- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason;
//询问委托人是否应该更改指定的文本
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
//询问委托人是否应删除文本字段的当前内容
//- (BOOL)textFieldShouldClear:(UITextField *)textField;
//询问委托人文本字段是否应处理按下返回按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}
#pragma mark —— lazyLoad
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.font = [UIFont systemFontOfSize:9.6
                                           weight:UIFontWeightRegular];
        _titleLab.textColor = kWhiteColor;
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self);
        }];
    }return _titleLab;
}

-(ZYTextField *)tf{
    if (!_tf) {
        _tf = ZYTextField.new;
        _tf.delegate = self;
        _tf.cj_delegate = self;
        _tf.backgroundColor = kBlackColor;
        _tf.alpha = 0.7;
        [self addSubview:_tf];
        [_tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(self);
            make.width.mas_equalTo(self.inputViewWidth * 0.7);
            if (![NSString isNullString:self.titleStr]) {
                make.top.equalTo(self.titleLab.mas_bottom).offset(3);
            }else{
                make.top.equalTo(self);
            }
        }];
    }return _tf;
}

-(UIButton *)countDownBtn{
    if (!_countDownBtn) {
        _countDownBtn = UIButton.new;
        _countDownBtn.titleBeginStr = @"";
        _countDownBtn.titleColor = [UIColor blueColor];
        _countDownBtn.bgCountDownColor = [UIColor redColor];
        _countDownBtn.bgEndColor = KLightGrayColor;
        _countDownBtn.layerCornerRadius = 6;
        _countDownBtn.titleRuningStr = @"重新发送";
        _countDownBtn.bgCountDownColor = KLightGrayColor;
        _countDownBtn.bgEndColor = KLightGrayColor;
        _countDownBtn.countDownBtnType = CountDownBtnType_countDown;
        _countDownBtn.showTimeType = ShowTimeType_SS;
        @weakify(self)
        [_countDownBtn actionCountDownBlock:^(id data) {
//            @strongify(self)
        }];
        
        [_countDownBtn timeFailBeginFrom:10];//
        
        _countDownBtn.titleLabelFont = [UIFont systemFontOfSize:8
                                                         weight:UIFontWeightRegular];
//
//        -(void)actionCountDownBlock:(MKDataBlock)countDownBlock;//倒计时需要触发调用的方法
//        -(void)timeFailBeginFrom:(NSInteger)timeCount;//倒计时时间次数
        
//        @property(nonatomic,strong)NSTimerManager *nsTimerManager;
//        @property(nonatomic,strong)NSString *titleBeginStr;
//        @property(nonatomic,strong)NSString *titleRuningStr;//倒计时过程中显示的非时间文字
//        @property(nonatomic,strong)NSString *titleEndStr;
//        @property(nonatomic,strong)UIColor *titleColor;
//        //倒计时开始前的背景色直接对此控件进行赋值 backgroundColor
//        @property(nonatomic,strong)UIColor *bgCountDownColor;//倒计时的时候此btn的背景色
//        @property(nonatomic,strong)UIColor *bgEndColor;//倒计时完全结束后的背景色
//        @property(nonatomic,strong)UIColor *layerBorderColor;
//        @property(nonatomic,strong)UIFont *titleLabelFont;
//        @property(nonatomic,assign)CGFloat layerCornerRadius;
//        @property(nonatomic,assign)CGFloat layerBorderWidth;
//        @property(nonatomic,assign)ShowTimeType showTimeType;//时间显示风格
//        @property(nonatomic,assign)long count;// 倒计时
//        @property(nonatomic,assign)ButtonType buttonType;
//        @property(nonatomic,copy)MKDataBlock countDownBlock;
        [self addSubview:_countDownBtn];
        [_countDownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.top.bottom.equalTo(self.tf);
            make.width.mas_equalTo(self.inputViewWidth * 0.27);
        }];

    }return _countDownBtn;
}

@end
