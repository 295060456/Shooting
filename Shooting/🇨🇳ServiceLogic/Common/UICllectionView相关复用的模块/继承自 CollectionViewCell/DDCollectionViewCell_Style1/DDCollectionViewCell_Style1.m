//
//  DDCollectionViewCell_Style1.m
//  DouDong-II
//
//  Created by Jobs on 2020/12/22.
//

#import "DDCollectionViewCell_Style1.h"

@interface DDCollectionViewCell_Style1 ()

@property(nonatomic,copy)MKDataBlock collectionViewCell_Style1Block;
@property(nonatomic,strong)UIView *shadeView;
@property(nonatomic,strong)UIButton *likeBtn;

@end

@implementation DDCollectionViewCell_Style1

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [UIView cornerCutToCircleWithView:self
                      andCornerRadius:6];
}

-(void)actionBlockCollectionViewCell_Style1:(MKDataBlock)collectionViewCell_Style1Block{
    self.collectionViewCell_Style1Block = collectionViewCell_Style1Block;
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    self.contentView.backgroundColor = RandomColor;
    self.shadeView.alpha = 1;
    [self.likeBtn setTitle:@"1024"
                  forState:UIControlStateNormal];
    [self.likeBtn.titleLabel sizeToFit];
    [self.likeBtn.titleLabel adjustsFontSizeToFitWidth];
}

+(CGSize)cellSizeWithModel:(id _Nullable)model{
    return CGSizeMake(111, 139);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    if (self.collectionViewCell_Style1Block) {
        self.collectionViewCell_Style1Block(@1);
    }
}
#pragma mark —— lazyLoad
-(UIView *)shadeView{
    if (!_shadeView) {
        _shadeView = UIView.new;
        _shadeView.backgroundColor = [kBlackColor colorWithAlphaComponent:0.5];
        [self.contentView addSubview:_shadeView];
        [_shadeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(16);
        }];
    }return _shadeView;
}

-(UIButton *)likeBtn{
    if (!_likeBtn) {
        _likeBtn = UIButton.new;
        [_likeBtn setImage:KIMG(@"❤")
                  forState:UIControlStateNormal];
        [_likeBtn setTitleColor:kWhiteColor
                       forState:UIControlStateNormal];
        _likeBtn.titleLabel.font = [UIFont systemFontOfSize:12
                                                     weight:UIFontWeightRegular];
        [self.shadeView addSubview:_likeBtn];
        [_likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self.shadeView);
        }];
    }return _likeBtn;
}

@end
