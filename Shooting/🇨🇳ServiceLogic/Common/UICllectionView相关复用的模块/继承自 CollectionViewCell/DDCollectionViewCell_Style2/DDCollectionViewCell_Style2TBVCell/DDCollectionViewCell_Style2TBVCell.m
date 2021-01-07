//
//  DDCollectionViewCell_Style2TBVCell.m
//  DouDong-II
//
//  Created by Jobs on 2021/1/6.
//

#import "DDCollectionViewCell_Style2TBVCell.h"

@interface DDCollectionViewCell_Style2TBVCell ()
//UI
@property(nonatomic,strong)UIImageView *userHeaderIMGV;
@property(nonatomic,strong)UILabel *usernameLab;
@property(nonatomic,strong)UILabel *postTimeLab;
@property(nonatomic,strong)UILabel *postContentLab;
//Data
@property(nonatomic,strong)DDCollectionViewCell_Style2TBVCellModel *collectionViewCell_Style2TBVCellModel;

@end

@implementation DDCollectionViewCell_Style2TBVCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    DDCollectionViewCell_Style2TBVCell *cell = (DDCollectionViewCell_Style2TBVCell *)[tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [[DDCollectionViewCell_Style2TBVCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                         reuseIdentifier:ReuseIdentifier];
        cell.backgroundColor = RGBSAMECOLOR(242);
        cell.contentView.backgroundColor = RGBSAMECOLOR(242);
        [UIView cornerCutToCircleWithView:cell andCornerRadius:6];
    }return cell;
}

+(CGFloat)cellHeightWithModel:(DDCollectionViewCell_Style2TBVCellModel *_Nullable)model{
    CGFloat othersHeight = 4 + 19 + 3 + 12 + 3 + 9;
    CGFloat contentTextHeight = 0;
    CGFloat offset = 0;
    if (![NSString isNullString:model.postContentStr]) {
        contentTextHeight = [NSString getContentHeightOrWidthWithParagraphStyleLineSpacing:1
                                                                     calcLabelHeight_Width:CalcLabelHeight
                                                                              effectString:model.postContentStr
                                                                                      font:[UIFont systemFontOfSize:13
                                                                                                             weight:UIFontWeightRegular]
                                                              boundingRectWithHeight_Width:SCREEN_WIDTH - (71 + 44)];
    }return othersHeight + contentTextHeight + offset;
}

-(void)richElementsInCellWithModel:(DDCollectionViewCell_Style2TBVCellModel *_Nullable)collectionViewCell_Style2TBVCellModel{
    self.collectionViewCell_Style2TBVCellModel = collectionViewCell_Style2TBVCellModel;
    if (self.collectionViewCell_Style2TBVCellModel) {
        self.userHeaderIMGV.alpha = 1;
        self.usernameLab.alpha = 1;
        self.postTimeLab.alpha = 1;
        self.postContentLab.alpha = 1;
    }
}
#pragma mark —— lazyLoad
-(UIImageView *)userHeaderIMGV{
    if (!_userHeaderIMGV) {
        _userHeaderIMGV = UIImageView.new;
        _userHeaderIMGV.image = self.collectionViewCell_Style2TBVCellModel.userHeaderIMG;
        [self.contentView addSubview:_userHeaderIMGV];
        [_userHeaderIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(29, 29));
            make.top.equalTo(self.contentView).offset(6);
            make.left.equalTo(self.contentView).offset(9);
        }];
        [UIView cornerCutToCircleWithView:_userHeaderIMGV andCornerRadius:29 / 2];
    }return _userHeaderIMGV;
}

-(UILabel *)usernameLab{
    if (!_usernameLab) {
        _usernameLab = UILabel.new;
        _usernameLab.text = self.collectionViewCell_Style2TBVCellModel.usernameStr;
        _usernameLab.textAlignment = NSTextAlignmentCenter;
        _usernameLab.font = [UIFont systemFontOfSize:13
                                              weight:UIFontWeightRegular];
        _usernameLab.textColor = kBlackColor;
        [_usernameLab sizeToFit];
        [self.contentView addSubview:_usernameLab];
        [_usernameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userHeaderIMGV);
            make.left.equalTo(self.userHeaderIMGV.mas_right).offset(6);
        }];
    }return _usernameLab;
}

-(UILabel *)postTimeLab{
    if (!_postTimeLab) {
        _postTimeLab = UILabel.new;
        _postTimeLab.textAlignment = NSTextAlignmentCenter;
        _postTimeLab.text = self.collectionViewCell_Style2TBVCellModel.postTimeStr;
        _postTimeLab.textColor = HEXCOLOR(0x999999);
        _postTimeLab.font = [UIFont systemFontOfSize:10
                                              weight:UIFontWeightRegular];
        [_postTimeLab sizeToFit];
        [self.contentView addSubview:_postTimeLab];
        [_postTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.usernameLab.mas_bottom).offset(3);
            make.left.equalTo(self.usernameLab);
        }];
    }return _postTimeLab;
}

-(UILabel *)postContentLab{
    if (!_postContentLab) {
        _postContentLab = UILabel.new;
        _postContentLab.text = self.collectionViewCell_Style2TBVCellModel.postContentStr;
        _postContentLab.numberOfLines = 0;
        _postContentLab.textAlignment = NSTextAlignmentLeft;
        _postContentLab.font = [UIFont systemFontOfSize:13
                                                 weight:UIFontWeightRegular];
        _postContentLab.textColor = kBlackColor;
        [_postContentLab sizeToFit];
        [self.contentView addSubview:_postContentLab];
        [_postContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.usernameLab);
            make.right.equalTo(self.contentView).offset(-5);
            make.top.equalTo(self.postTimeLab.mas_bottom).offset(3);
        }];
    }return _postContentLab;
}

@end
