//
//  HomeCollectionViewCellTwo.m
//  Bored
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 何顺育. All rights reserved.
//

#import "HomeCollectionViewCellTwo.h"

@implementation HomeCollectionViewCellTwo
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setupViews];
    }
    return self;
}
- (void)p_setupViews
{
    self.imv = [[UIImageView alloc] init];
    //    self.imv.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:self.imv];
    
    
    self.v1 = [[UIView alloc] init];
    self.v1.backgroundColor = [UIColor clearColor];
    self.v1.alpha = 0.7;
    [self.imv addSubview:self.v1];
    
    self.titleLabel = [[UILabel alloc] init];
    //    self.titleLabel.backgroundColor = [UIColor greenColor];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.0f];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.highlighted = YES;
    [self.v1 addSubview:self.titleLabel];
    
    self.readnumLabel = [[UILabel alloc] init];
    //    self.readnumLabel.backgroundColor = [UIColor orangeColor];
    self.readnumLabel.font = [UIFont systemFontOfSize:12.0f];
    
    self.readnumLabel.textColor = [UIColor groupTableViewBackgroundColor];
    [self.v1 addSubview:self.readnumLabel];
    
    self.v2 = [[UIView alloc] init];
    _v1.backgroundColor = [UIColor blackColor];
    _v2.alpha = 0.7;
    [self.imv addSubview:_v2];
    
    
    self.imv2 = [[UIImageView alloc] init];
    //    self.imv2.backgroundColor = [UIColor yellowColor];
    [self.v2 addSubview:self.imv2];
    
    
    self.l1 = [[UILabel alloc] init];
    //    self.l1.backgroundColor = [UIColor orangeColor];
    self.l1.textColor = [UIColor colorWithRed:253/225.0 green:201/225.0 blue:47/225.0 alpha:1];
    self.l1.font = [UIFont systemFontOfSize:10.0f];
    [self.v2 addSubview:self.l1];
    
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.imv.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    
    self.v1.frame = CGRectMake(0, self.contentView.frame.size.height - 80, self.contentView.frame.size.width, 80);
    
    self.titleLabel.frame = CGRectMake(10, 5, self.contentView.frame.size.width - 20, 50);
    self.readnumLabel.frame = CGRectMake(10, CGRectGetMaxY(self.titleLabel.frame) + 5, self.contentView.frame.size.width - 20, 10);
    
    _v2.frame = CGRectMake(10, self.imv.frame.size.height - 20, 40, 15);
    self.imv2.frame = CGRectMake(0, 0, 15, 15);
    self.l1.frame = CGRectMake(CGRectGetMaxX(self.imv2.frame), 0, 25, 15);
}
@end
