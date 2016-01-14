//
//  HomeCollectionViewCellOne.h
//  Bored
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 何顺育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Home.h"
@interface HomeCollectionViewCellOne : UICollectionViewCell
@property (nonatomic, strong)UIImageView * imageView;
@property (nonatomic, strong) UILabel * label;
@property (nonatomic, strong) UIView * v1;
@property (nonatomic, strong)UIImageView * imv;
@property (nonatomic, strong)UILabel * l1;


- (void)bindModel:(Home *)model;
@end
