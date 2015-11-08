//
//  MenuTableViewController.h
//  SlideViewTest
//
//  Created by wamaker on 15/11/6.
//  Copyright © 2015年 wamaker. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^getIndex)(NSInteger index);

@interface MenuTableViewController : UITableViewController

- (void)setIndexBlock:(getIndex)getIndex;

@end
