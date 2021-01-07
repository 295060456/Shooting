//
//  DDCollectionViewCell_Style2+UITableViewDelegate.m
//  DouDong-II
//
//  Created by Jobs on 2021/1/6.
//

#import "DDCollectionViewCell_Style2+UITableViewDelegate.h"

@implementation DDCollectionViewCell_Style2 (UITableViewDelegate)

#pragma mark —————————— UITableViewDelegate ——————————
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [DDCollectionViewCell_Style2TBVCell cellHeightWithModel:self.invitationModel.commentModelArr[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
}

@end
