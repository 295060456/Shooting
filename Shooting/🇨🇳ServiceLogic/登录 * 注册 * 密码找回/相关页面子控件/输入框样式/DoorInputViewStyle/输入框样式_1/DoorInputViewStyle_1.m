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
@property(nonatomic,assign)int time;
@property(nonatomic,copy)MKDataBlock doorInputViewStyle_1CountDownBtnClickBlock;
@property(nonatomic,copy)FourDataBlock doorInputViewStyle_1Block;
@property(nonatomic,assign)BOOL isOK;

@end

@implementation DoorInputViewStyle_1

-(instancetype)init{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(doorInputViewStyle_1Notification:)
                                                     name:@"短信验证码时间"
                                                   object:nil];
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        if (![NSString isNullString:self.titleStr]) {
            self.titleLab.text = self.titleStr;
        }
        self.tf.alpha = 1;
        self.isOK = YES;
    }
}
#pragma mark —— CJTextFieldDeleteDelegate
- (void)cjTextFieldDeleteBackward:(CJTextField *)textField{
    if (self.doorInputViewStyle_1Block) {
        self.doorInputViewStyle_1Block(self,
                                       textField,
                                       @"",
                                       NSStringFromSelector(_cmd));
    }
}
#pragma mark —— UITextFieldDelegate
//询问委托人是否应该在指定的文本字段中开始编辑
- (BOOL)textFieldShouldBeginEditing:(ZYTextField *)textField{
    return YES;
}
//告诉委托人在指定的文本字段中开始编辑
//- (void)textFieldDidBeginEditing:(ZYTextField *)textField;
//询问委托人是否应在指定的文本字段中停止编辑
- (BOOL)textFieldShouldEndEditing:(ZYTextField *)textField{
    return YES;
}
//告诉委托人对指定的文本字段停止编辑
- (void)textFieldDidEndEditing:(ZYTextField *)textField{
    [self.tf isEmptyText];
    if (self.doorInputViewStyle_1Block) {
        self.doorInputViewStyle_1Block(self,
                                       textField,
                                       @"",
                                       NSStringFromSelector(_cmd));
    }
}
//告诉委托人对指定的文本字段停止编辑
//- (void)textFieldDidEndEditing:(UITextField *)textField
//reason:(UITextFieldDidEndEditingReason)reason;
//询问委托人是否应该更改指定的文本
- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string{
    if (self.doorInputViewStyle_1Block) {
        self.doorInputViewStyle_1Block(self,
                                       textField,
                                       string,
                                       NSStringFromSelector(_cmd));
    }return YES;
}
//询问委托人是否应删除文本字段的当前内容
//- (BOOL)textFieldShouldClear:(UITextField *)textField;
//询问委托人文本字段是否应处理按下返回按钮
- (BOOL)textFieldShouldReturn:(ZYTextField *)textField{
    [self endEditing:YES];
    return YES;
}

-(void)actionBlockDoorInputViewStyle_1CountDownBtnClick:(MKDataBlock)doorInputViewStyle_1CountDownBtnClickBlock{
    _doorInputViewStyle_1CountDownBtnClickBlock = doorInputViewStyle_1CountDownBtnClickBlock;
}

-(void)actionBlockdoorInputViewStyle_1:(FourDataBlock)doorInputViewStyle_1Block{
    _doorInputViewStyle_1Block = doorInputViewStyle_1Block;
}

-(void)doorInputViewStyle_1Notification:(NSNotification *)notification{
    NSString *info = notification.object;
    self.time = info.intValue;
    self.countDownBtn.alpha = 1;
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
        _tf.returnKeyType = UIReturnKeyDone;
        _tf.keyboardAppearance = UIKeyboardAppearanceAlert;
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
                                     layerCornerRadius:6
                                      layerBorderColor:nil
                                            titleColor:kWhiteColor
                                         titleBeginStr:@"发送验证码"
                                        titleLabelFont:[UIFont systemFontOfSize:8
                                                                         weight:UIFontWeightRegular]];
        _countDownBtn.titleRuningStr = @"重新发送\n";
        _countDownBtn.titleLabel.numberOfLines = 0;
        _countDownBtn.titleEndStr = @"重新发送";
        _countDownBtn.backgroundColor = kBlackColor;
        _countDownBtn.alpha = 0.7f;
        _countDownBtn.bgCountDownColor = kBlackColor;//倒计时的时候此btn的背景色
        _countDownBtn.bgEndColor = kBlackColor;//倒计时完全结束后的背景色
        _countDownBtn.showTimeType = ShowTimeType_SS;
        _countDownBtn.countDownBtnNewLineType = CountDownBtnNewLineType_newLine;
        
        [_countDownBtn timeFailBeginFrom:self.time];//注销这句话就是手动启动，放开这句话就是自启动
        
        @weakify(self)
        [_countDownBtn actionCountDownClickEventBlock:^(id data) {
            @strongify(self)
            if (self.doorInputViewStyle_1CountDownBtnClickBlock) {
                self.doorInputViewStyle_1CountDownBtnClickBlock(data);
            }
        }];
        [self addSubview:_countDownBtn];
        [_countDownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.bottom.equalTo(self.tf);
            make.height.mas_equalTo(self.inputViewHeight - 14);
            make.width.mas_equalTo(self.inputViewWidth * 0.27);
        }];
  
        [self layoutIfNeeded];
        [UIView appointCornerCutToCircleWithTargetView:_countDownBtn
                                     byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight
                                           cornerRadii:CGSizeMake(self.inputViewHeight / 2,
                                                                  self.inputViewHeight / 2)];

    }return _countDownBtn;
}

@end
