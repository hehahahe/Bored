//
//  HomeCollectionViewCellOne.m
//  Bored
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 何顺育. All rights reserved.
//

#import "HomeCollectionViewCellOne.h"

@interface HomeCollectionViewCellOne ()
@property (nonatomic, assign) float h;
@end
@implementation HomeCollectionViewCellOne
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
    self.imageView = [[UIImageView alloc] init];
    self.imageView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.imageView];
    
    self.label = [[UILabel alloc] init];
//    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = [UIColor blackColor];
    self.label.font = [UIFont systemFontOfSize:16.0f];
    self.label.backgroundColor = [UIColor whiteColor];
    self.label.numberOfLines = 0;
//    self.label.alpha = 0.7;
    [self.contentView addSubview:self.label];
    
    
    self.v1 = [[UIView alloc] init];
    _v1.backgroundColor = [UIColor blackColor];
    _v1.alpha = 0.7;
    [self.imageView addSubview:_v1];
    
    
    self.imv = [[UIImageView alloc] init];
//    self.imv.backgroundColor = [UIColor yellowColor];
    [self.v1 addSubview:self.imv];
    
    
    self.l1 = [[UILabel alloc] init];
//    self.l1.backgroundColor = [UIColor orangeColor];
    self.l1.textColor = [UIColor colorWithRed:253/225.0 green:201/225.0 blue:47/225.0 alpha:1];
    self.l1.font = [UIFont systemFontOfSize:10.0f];
    [self.v1 addSubview:self.l1];
    
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 3/5);
    self.label.frame = CGRectMake(10, CGRectGetMaxY(self.imageView.frame) + 3, CGRectGetWidth(self.imageView.frame) - 20, self.h);
   _v1.frame = CGRectMake(10, self.imageView.frame.size.height - 20, 40, 15);
    self.imv.frame = CGRectMake(0, 0, 15, 15);
    self.l1.frame = CGRectMake(CGRectGetMaxX(self.imv.frame), 0, 25, 15);
    
}

- (void)bindModel:(Home *)model
{
    CGRect r = [model.post[@"title"] boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.contentView.frame) - 10, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0f]} context:nil];
    self.h = r.size.height;
//    NSLog(@"%f", self.h);
}
@end
