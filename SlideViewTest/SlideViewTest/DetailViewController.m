//
//  DetailViewController.m
//  SlideViewTest
//
//  Created by wamaker on 15/11/6.
//  Copyright © 2015年 wamaker. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (strong, nonatomic) NSArray *menuItems;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation DetailViewController

- (instancetype)initWithArray:(NSArray *)menuItems {
    if (self = [super init]) {
        self.menuItems = menuItems;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setIndex:(NSInteger)index {
    _index = index;
    
    NSDictionary *menuItem = self.menuItems[index];
    NSArray *color = menuItem[@"colors"];
    CGFloat r = [color[0] doubleValue];
    CGFloat g = [color[1] doubleValue];
    CGFloat b = [color[2] doubleValue];
    self.view.backgroundColor = [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1.0];
    
    self.imageView.image = [UIImage imageNamed:menuItem[@"bigImage"]];
}

@end
