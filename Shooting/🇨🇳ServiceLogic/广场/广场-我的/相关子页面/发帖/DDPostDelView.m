//
//  DDPostDelView.m
//  DouDong-II
//
//  Created by Jobs on 2021/1/1.
//

#import "DDPostDelView.h"

@interface DDPostDelView ()
//UI
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *imageView;
//Data
@property(nonatomic,copy)MKDataBlock postDelViewBlock;

@end

@implementation DDPostDelView

-(void)richElementsInCellWithModel:(BOOL)model{
    self.backgroundColor = kRedColor;
    self.imageView.highlighted = model;
    self.imageView.image = model ? KIMG(@"hx_photo_edit_trash_open") : KIMG(@"hx_photo_edit_trash_close");
    self.titleLab.text = model ? @"松手即可删除" : @"拖动到此处删除";
}

-(void)actionBlockDDPostDelView:(MKDataBlock)postDelViewBlock{
    self.postDelViewBlock = postDelViewBlock;
}
#pragma mark —— lazyLoad
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = UIImageView.new;
        _imageView.image = KIMG(@"hx_photo_edit_trash_close");
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(5);
        }];
    }return _imageView;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.backgroundColor = kRedColor;
        _titleLab.text = @"拖动到此处删除";
        _titleLab.textColor = kWhiteColor;
        _titleLab.textAlignment = NSTextAlignmentCenter;
//        _detailTextLab.font =
        [_titleLab sizeToFit];
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageView.mas_bottom).offset(5);
            make.centerX.equalTo(self);
        }];
    }return _titleLab;
}

@end
