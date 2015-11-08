//
//  MenuItemCell.h
//  SlideViewTest
//
//  Created by wamaker on 15/11/7.
//  Copyright © 2015年 wamaker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuItemCell : UITableViewCell

- (void)configureForMenuItem:(NSDictionary *)menuItem;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
