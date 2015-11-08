//
//  MenuItemCell.m
//  SlideViewTest
//
//  Created by wamaker on 15/11/7.
//  Copyright © 2015年 wamaker. All rights reserved.
//

#import "MenuItemCell.h"

@interface MenuItemCell ()

@property (weak, nonatomic) IBOutlet UIImageView *menuItemImageView;

@end

@implementation MenuItemCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureForMenuItem:(NSDictionary *)menuItem {
    self.menuItemImageView.image = [UIImage imageNamed:menuItem[@"image"]];
    NSArray *color = menuItem[@"colors"];
    CGFloat r = [color[0] doubleValue];
    CGFloat g = [color[1] doubleValue];
    CGFloat b = [color[2] doubleValue];
    self.backgroundColor = [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1.0];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"MenuItemCell";
    MenuItemCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil] lastObject];
    }
    
    return cell;
}

@end
