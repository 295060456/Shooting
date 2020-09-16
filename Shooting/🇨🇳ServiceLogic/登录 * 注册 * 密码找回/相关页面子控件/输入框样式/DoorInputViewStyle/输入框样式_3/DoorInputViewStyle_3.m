//
//  DoorInputViewStyle_3.m
//  Shooting
//
//  Created by Jobs on 2020/9/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "DoorInputViewStyle_3.h"

@interface DoorInputViewStyle_3 ()
<
UITextFieldDelegate
,CJTextFieldDeleteDelegate
>

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *securityModeBtn;

@end

@implementation DoorInputViewStyle_3

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
    if (self.isShowSecurityMode) {
        self.securityModeBtn.alpha = self.isShowSecurityMode;
        self.securityModeBtn.selected = self.isShowSecurityMode;
        self.tf.secureTextEntry = self.isShowSecurityMode;
    }
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
    [self.tf isEmptyText];
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
        _tf.backgroundColor = kBlackColor;
        _tf.alpha = 0.7;
        _tf.cj_delegate = self;
        [self addSubview:_tf];
        [_tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(self);
            make.width.mas_equalTo(self.inputViewWidth * 0.86);
            if (![NSString isNullString:self.titleStr]) {
                make.top.equalTo(self.titleLab.mas_bottom).offset(3);
            }else{
                make.top.equalTo(self);
            }
        }];
    }return _tf;
}

-(UIButton *)securityModeBtn{
    if (!_securityModeBtn) {
        _securityModeBtn = UIButton.new;
        [_securityModeBtn setImage:self.btnSelectedIMG
                          forState:UIControlStateNormal];
        [_securityModeBtn setImage:self.btnUnSelectedIMG
                          forState:UIControlStateSelected];
        @weakify(self)
        [[_securityModeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            x.selected = !x.selected;
            [self.tf setIsShowSecurityMode:x.selected];
        }];
        [self.tf addSubview:_securityModeBtn];
        [_securityModeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.tf).offset(-20);
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.centerY.equalTo(self.tf);
        }];
    }return _securityModeBtn;
}

@end
