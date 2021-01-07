//
//  DDCollectionViewCell_Style2+UITableViewDataSource.m
//  DouDong-II
//
//  Created by Jobs on 2021/1/6.
//

#import "DDCollectionViewCell_Style2+UITableViewDataSource.h"

@implementation DDCollectionViewCell_Style2 (UITableViewDataSource)

#pragma mark —— UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section{
    switch (self.invitationModel.style2Location) {
        case DDCollectionViewCell_Style2LocationUsersList:{
            return self.invitationModel.commentModelArr.count >= 3 ? 3 : self.invitationModel.commentModelArr.count;
        }break;
        case DDCollectionViewCell_Style2LocationUserDetail:{
            return self.invitationModel.commentModelArr.count;
        }default:
            return 0;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DDCollectionViewCell_Style2TBVCell *cell = [DDCollectionViewCell_Style2TBVCell cellWithTableView:tableView];
    [cell richElementsInCellWithModel:self.invitationModel.commentModelArr[indexPath.row]];
    return cell;
}

@end
