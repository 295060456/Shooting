//
//  DDCollectionViewCell_Style3.m
//  DouDong-II
//
//  Created by Jobs on 2020/12/27.
//

#import "DDCollectionViewCell_Style3.h"

@interface DDCollectionViewCell_Style3 ()
// UI
@property(nonatomic,strong)UIImageView *imageView;
// Data
@property(nonatomic,copy)MKDataBlock collectionViewCell_Style3Block;

@end

@implementation DDCollectionViewCell_Style3

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

-(void)actionBlockCollectionViewCell_Style3:(MKDataBlock)collectionViewCell_Style3Block{
    self.collectionViewCell_Style3Block = collectionViewCell_Style3Block;
}

-(void)richElementsInCellWithModel:(UIImage * _Nullable)model{
    self.imageView.image = model;
}

+(CGSize)cellSizeWithModel:(id _Nullable)model{
    return CGSizeMake(SCREEN_WIDTH / 3.7,SCREEN_WIDTH / 3.7);
}
#pragma mark —— lazyLoad
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = UIImageView.new;
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }return _imageView;
}

@end
