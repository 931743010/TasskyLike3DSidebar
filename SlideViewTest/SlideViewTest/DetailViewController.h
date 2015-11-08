//
//  DetailViewController.h
//  SlideViewTest
//
//  Created by wamaker on 15/11/6.
//  Copyright © 2015年 wamaker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (assign, nonatomic) NSInteger index;

- (instancetype)initWithArray:(NSArray *)menuItems;

@end
