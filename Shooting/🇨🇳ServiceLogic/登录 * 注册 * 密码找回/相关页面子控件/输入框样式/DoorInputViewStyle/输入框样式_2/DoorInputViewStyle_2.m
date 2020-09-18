//
//  DoorInputViewStyle_2.m
//  Shooting
//
//  Created by Jobs on 2020/9/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "DoorInputViewStyle_2.h"

@interface DoorInputViewStyle_2 ()
<
UITextFieldDelegate
,CJTextFieldDeleteDelegate
>

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,copy)MKDataBlock doorInputViewStyle_2ImageCodeBlock;
@property(nonatomic,copy)FourDataBlock doorInputViewStyle_2Block;
@property(nonatomic,assign)BOOL isOK;

@end

@implementation DoorInputViewStyle_2

-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        if (![NSString isNullString:self.titleStr]) {
            self.titleLab.text = self.titleStr;
        }
        self.tf.alpha = 1;
        self.imageCodeView.alpha = 1;
        self.isOK = YES;
    }

}
#pragma mark —— CJTextFieldDeleteDelegate
- (void)cjTextFieldDeleteBackward:(CJTextField *)textField{
    if (self.doorInputViewStyle_2Block) {
        self.doorInputViewStyle_2Block(self,
                                       textField,
                                       @"",
                                       NSStringFromSelector(_cmd));
    }
}
#pragma mark —— UITextFieldDelegate
//询问委托人是否应该在指定的文本字段中开始编辑
- (BOOL)textFieldShouldBeginEditing:(ZYTextField *)textField{
    return textField.isEditting = YES;
}
//告诉委托人在指定的文本字段中开始编辑
//- (void)textFieldDidBeginEditing:(ZYTextField *)textField{}
//询问委托人是否应在指定的文本字段中停止编辑
- (BOOL)textFieldShouldEndEditing:(ZYTextField *)textField{
    textField.isEditting = NO;
    return YES;
}
//告诉委托人对指定的文本字段停止编辑
- (void)textFieldDidEndEditing:(ZYTextField *)textField{
    [self.tf isEmptyText];
    if (self.doorInputViewStyle_2Block) {
        self.doorInputViewStyle_2Block(self,
                                       textField,
                                       @"",
                                       NSStringFromSelector(_cmd));
    }
}
//告诉委托人对指定的文本字段停止编辑
//- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason;
//询问委托人是否应该更改指定的文本
- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string{
    if (self.doorInputViewStyle_2Block) {
        self.doorInputViewStyle_2Block(self,
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
    textField.isEditting = NO;
    return YES;
}

-(void)actionBlockDoorInputViewStyle_2:(FourDataBlock)doorInputViewStyle_2Block{
    _doorInputViewStyle_2Block = doorInputViewStyle_2Block;
}

-(void)actionBlockDoorInputViewStyle_2ImageCode:(MKDataBlock)doorInputViewStyle_2ImageCodeBlock{
    _doorInputViewStyle_2ImageCodeBlock = doorInputViewStyle_2ImageCodeBlock;
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
            make.width.mas_equalTo(self.inputViewWidth * 0.66);
            if (![NSString isNullString:self.titleStr]) {
                make.top.equalTo(self.titleLab.mas_bottom).offset(3);
            }else{
                make.top.equalTo(self);
            }
        }];
        [self layoutIfNeeded];
    }return _tf;
}

-(ImageCodeView *)imageCodeView{
    if (!_imageCodeView) {
        _imageCodeView = ImageCodeView.new;
        _imageCodeView.alpha = 0.7;
        _imageCodeView.bgColor = kBlackColor;
        @weakify(self)
        [_imageCodeView actionBlockImageCodeView:^(id data) {
            @strongify(self)
            if (self.doorInputViewStyle_2ImageCodeBlock) {
                self.doorInputViewStyle_2ImageCodeBlock(data);
            }
        }];
        [self addSubview:_imageCodeView];
        [_imageCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self.tf.mas_right).offset(5);
            make.width.mas_equalTo(50);
        }];
        [self layoutIfNeeded];
        [UIView appointCornerCutToCircleWithTargetView:_imageCodeView
                                     byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight
                                           cornerRadii:CGSizeMake(self.inputViewHeight / 2, self.inputViewHeight / 2)];
    }return _imageCodeView;
}

@end
