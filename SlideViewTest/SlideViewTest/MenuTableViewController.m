//
//  MenuTableViewController.m
//  SlideViewTest
//
//  Created by wamaker on 15/11/6.
//  Copyright © 2015年 wamaker. All rights reserved.
//

#import "MenuTableViewController.h"
#import "MenuItemCell.h"

@interface MenuTableViewController ()

@property (copy, nonatomic) getIndex getIndex;

@property (strong, nonatomic) NSArray *menuItems;

@end

@implementation MenuTableViewController

- (NSArray *)menuItems {
    if (_menuItems == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"MenuItems" ofType:@"plist"];
        _menuItems = [NSArray arrayWithContentsOfFile:path];
    }
    return _menuItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setIndexBlock:(getIndex)getIndex {
    self.getIndex = getIndex;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuItemCell *cell = [MenuItemCell cellWithTableView:tableView];
    NSDictionary *menuItem = self.menuItems[indexPath.row];
    [cell configureForMenuItem:menuItem];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return MAX(80, CGRectGetHeight(self.view.bounds) * 1.0 / self.menuItems.count);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.getIndex(indexPath.row);
}

@end
