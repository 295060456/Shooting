//
//  DDPostInputView.m
//  DouDong-II
//
//  Created by Jobs on 2020/12/28.
//

#import "DDPostInputView.h"

static int inputAstrict = 2000;

@interface DDPostInputView ()
//UI
@property(nonatomic,strong)SZTextView *textView;
@property(nonatomic,strong)UILabel *checkLab;
//Data
@property(nonatomic,copy)MKDataBlock postInputViewBlock;

@end

@implementation DDPostInputView

-(void)actionBlockDDPostInputView:(MKDataBlock)postInputViewBlock{
    self.postInputViewBlock = postInputViewBlock;
}

-(void)richElementsInCellWithModel:(NSString *_Nullable)model{
    self.textView.text = model;
    self.checkLab.alpha = 1;
}
#pragma mark —— UITextViewDelegate
//在textView获得焦点之前会调用
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    NSLog(@"");
    return YES;
}
//当textView失去焦点之前会调用
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    NSLog(@"");
    return YES;
}
//当textView获得焦点之后，并且已经是第一响应者（first responder），那么会调用
- (void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"");
}
//结束编辑
- (void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"");
}
//内容将要发生改变编辑
- (BOOL)textView:(UITextView *)textView
shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text{
    
    NSMutableString *tempMutString = [[NSMutableString alloc] initWithString:textView.text];
    [tempMutString deleteCharactersInRange:range];
    [tempMutString appendFormat:@"%@", text];

    NSLog(@"AAAstring = %@",tempMutString);
    if (self.postInputViewBlock) {
        self.postInputViewBlock(tempMutString);
    }

    self.checkLab.text = [NSString stringWithFormat:@"%lu/2000",(unsigned long)tempMutString.length];
    return (tempMutString.length != inputAstrict);
}
//内容发生改变编辑
- (void)textViewDidChange:(UITextView *)textView{
    NSLog(@"");
}
//焦点发生改变
- (void)textViewDidChangeSelection:(UITextView *)textView{}
//指定范围的内容与 URL 将要相互作用时激发该方法——该方法随着 iOS7被使用
- (BOOL)textView:(UITextView *)textView
shouldInteractWithURL:(NSURL *)URL
         inRange:(NSRange)characterRange
     interaction:(UITextItemInteraction)interaction{
    NSLog(@"");
    return YES;
}
//textView指定范围的内容与文本附件将要相互作用时,自动激发该方法——该方法随着 iOS7被使用;
- (BOOL)textView:(UITextView *)textView
shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment
         inRange:(NSRange)characterRange
     interaction:(UITextItemInteraction)interaction{
    NSLog(@"");
    return YES;
}

//- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange API_DEPRECATED_WITH_REPLACEMENT("textView:shouldInteractWithURL:inRange:interaction:", ios(7.0, 10.0));
//- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange API_DEPRECATED_WITH_REPLACEMENT("textView:shouldInteractWithTextAttachment:inRange:interaction:", ios(7.0, 10.0));
#pragma mark —— lazyLoad
-(SZTextView *)textView{
    if (!_textView) {
        _textView = SZTextView.new;
        _textView.backgroundColor = kWhiteColor;
        _textView.delegate = self;
        _textView.placeholder = @"说点什么好呢";
        _textView.placeholderTextColor = KLightGrayColor;
        _textView.font = [UIFont fontWithName:@"HelveticaNeue-Light"
                                         size:18.0];
        [self addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }return _textView;
}

-(UILabel *)checkLab{
    if (!_checkLab) {
        _checkLab = UILabel.new;
        _checkLab.text = @"0/2000";
        _checkLab.textColor = KLightGrayColor;
        _checkLab.font = [UIFont systemFontOfSize:12
                                           weight:UIFontWeightMedium];
        [self.textView addSubview:_checkLab];
        [_checkLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-40);
            make.bottom.equalTo(self).offset(-8);
        }];
    }return _checkLab;
}

@end
