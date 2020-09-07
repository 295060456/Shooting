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
        _countDownBtn = [[UIButton alloc] initWithType:CountDownBtnType_countDown
                                               runType:CountDownBtnRunType_manual
                                      layerBorderWidth:0
                                     layerCornerRadius:0
                                      layerBorderColor:nil
                                            titleColor:kWhiteColor
                                         titleBeginStr:@"发送验证码"
                                        titleLabelFont:[UIFont systemFontOfSize:8
                                                                         weight:UIFontWeightRegular]];
        _countDownBtn.titleBeginStr = @"发送验证码";
        _countDownBtn.titleRuningStr = @"重新发送\n";
        _countDownBtn.titleLabel.numberOfLines = 0;
        _countDownBtn.titleEndStr = @"重新发送";
        _countDownBtn.backgroundColor = KLightGrayColor;
        _countDownBtn.titleColor = kWhiteColor;
        _countDownBtn.bgCountDownColor = KLightGrayColor;//倒计时的时候此btn的背景色
        _countDownBtn.bgEndColor = KLightGrayColor;//倒计时完全结束后的背景色
        _countDownBtn.layerCornerRadius = 6;
        _countDownBtn.showTimeType = ShowTimeType_SS;
        _countDownBtn.titleLabelFont = [UIFont systemFontOfSize:8
                                                         weight:UIFontWeightRegular];
        _countDownBtn.countDownBtnNewLineType = CountDownBtnNewLineType_newLine;
        
        [_countDownBtn timeFailBeginFrom:5];//注销这句话就是手动启动，放开这句话就是自启动
        
//        @weakify(self)
        [_countDownBtn actionCountDownClickEventBlock:^(id data) {
//            @strongify(self)
            NSLog(@"MMP");
        }];
        [self addSubview:_countDownBtn];
        [_countDownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.top.bottom.equalTo(self.tf);
            make.width.mas_equalTo(self.inputViewWidth * 0.27);
        }];

    }return _countDownBtn;
}

@end
