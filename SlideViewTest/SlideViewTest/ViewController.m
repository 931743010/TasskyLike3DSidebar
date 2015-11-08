//
//  ViewController.m
//  SlideViewTest
//
//  Created by wamaker on 15/11/6.
//  Copyright © 2015年 wamaker. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "MenuTableViewController.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self

@interface ViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) UINavigationController *navi;

@property (strong, nonatomic) NSArray *menuItems;
@property (strong, nonatomic) DetailViewController *detail;
@property (strong, nonatomic) MenuTableViewController *menu;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MenuItems" ofType:@"plist"];
    self.menuItems = [NSArray arrayWithContentsOfFile:path];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    DetailViewController *detail = [[DetailViewController alloc] initWithArray:self.menuItems];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:detail];
    navi.view.frame = CGRectMake(80, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    [self addChildViewController:navi];
    [self.scrollView addSubview:navi.view];
    self.navi = navi;
    self.detail = detail;
    self.detail.index = 0;
    
    MenuTableViewController *menu = [[MenuTableViewController alloc] init];
    menu.view.frame = CGRectMake(0, 0, 80, CGRectGetHeight(self.view.frame));
    [self addChildViewController:menu];
    [self.scrollView addSubview:menu.view];
    self.menu = menu;
    
    WS(weakSelf);
    [self.menu setIndexBlock:^(NSInteger index) {
        weakSelf.detail.index = index;
        [weakSelf hideOrShowMenu:NO animated:YES];
    }];
    
    self.scrollView.contentSize = CGSizeMake(80 + CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    
    [self hideOrShowMenu:NO animated:NO];
    
    self.menu.view.layer.anchorPoint = CGPointMake(1.0, 0.5);
}

- (void)hideOrShowMenu:(BOOL)show animated:(BOOL)animated {
    CGFloat menuOffset = 80;
    [self.scrollView setContentOffset:(show ? CGPointZero : CGPointMake(menuOffset, 0)) animated:animated];
}

- (CATransform3D)transformForFraction:(CGFloat)fraction {
    CATransform3D identity = CATransform3DIdentity;
    identity.m34 = -1.0 / 1000;
    double angle = (1.0 - fraction) * -M_PI_2;
    CGFloat xOffset = 80 * 0.5;
    CATransform3D rotateTransform = CATransform3DRotate(identity, angle, 0.0, 1.0, 0.0);
    CATransform3D translateTransform = CATransform3DMakeTranslation(xOffset, 0.0, 0.0);
    return CATransform3DConcat(rotateTransform, translateTransform);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    scrollView.pagingEnabled = scrollView.contentOffset.x < (scrollView.contentSize.width - CGRectGetWidth(scrollView.frame));
    
    double multiplier = 1.0 / 80;
    CGFloat offset = scrollView.contentOffset.x * multiplier;
    CGFloat fraction = 1.0 - offset;
    self.menu.view.layer.transform = [self transformForFraction:fraction];
    self.menu.view.alpha = fraction;
}

@end
