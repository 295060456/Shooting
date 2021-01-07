//
//  DDCollectionViewCell_Style4.m
//  DouDong-II
//
//  Created by Jobs on 2020/12/28.
//

#import "DDCollectionViewCell_Style4.h"

@interface DDCollectionViewCell_Style4 ()
// UI
@property(nonatomic,strong)UIImageView *imageView;
// Data
@property(nonatomic,copy)MKDataBlock collectionViewCell_Style4Block;

@end

@implementation DDCollectionViewCell_Style4

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
//        [UIView makeTargetShadowview:self
//                           superView:nil
//                     shadowDirection:ShadowDirection_rightDown
//                   shadowWithOffsetX:5
//                             offsetY:5
//                        cornerRadius:10
//                        shadowOffset:defaultSize
//                       shadowOpacity:0.5
//                    layerShadowColor:defaultObj
//                   layerShadowRadius:defaultValue];
        self.backgroundColor = kWhiteColor;
        [UIView cornerCutToCircleWithView:self
                          andCornerRadius:6];
    }return self;
}

-(void)actionBlockCollectionViewCell_Style4:(MKDataBlock)collectionViewCell_Style4Block{
    self.collectionViewCell_Style4Block = collectionViewCell_Style4Block;
}

-(void)richElementsInCellWithModel:(UIImage * _Nullable)model{
    self.imageView.alpha = 1;
}

+(CGSize)cellSizeWithModel:(id _Nullable)model{
    return CGSizeMake(SCREEN_WIDTH - 12 * 2,130);
}
#pragma mark —— lazyLoad
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = UIImageView.new;
        _imageView.image = KIMG(@"广告");
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }return _imageView;
}

@end
