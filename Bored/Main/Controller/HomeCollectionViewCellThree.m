//
//  HomeCollectionViewCellThree.m
//  Bored
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 何顺育. All rights reserved.
//

#import "HomeCollectionViewCellThree.h"

@implementation HomeCollectionViewCellThree
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
    
    self.imv2 = [[UIImageView alloc] init];
    //    self.imv2.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:self.imv2];
    
    
    self.titleLabel = [[UILabel alloc] init];
    //    self.titleLabel.backgroundColor = [UIColor greenColor];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [self.contentView addSubview:self.titleLabel];
    
    self.readnumLabel = [[UILabel alloc] init];
    //    self.readnumLabel.backgroundColor = [UIColor orangeColor];
    self.readnumLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.contentView addSubview:self.readnumLabel];
    
    
    
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.imv.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height - 50);
    
    self.imv2.frame = CGRectMake(10, self.imv.frame.size.height - 40, 30, 30);
    
    self.titleLabel.frame = CGRectMake(10, CGRectGetMaxY(self.imv.frame) + 5, self.imv.frame.size.width - 20, 20);
    self.readnumLabel.frame = CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.titleLabel.frame) + 10, self.titleLabel.frame.size.width, 10);
    
}
@end
