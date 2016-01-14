//
//  HomeDataHandle.h
//  Bored
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 何顺育. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Home.h"
@interface HomeDataHandle : NSObject
+ (HomeDataHandle *)defaultDataHandle;
- (void)loadDataWithUrlstring:(NSString *)urlstring;
- (void)loadDataWithUrl:(NSString *)urlStr;
- (NSInteger)modelCount;
@property (nonatomic, strong)NSMutableArray * HeaderArray;

- (Home *)modelWithIndex:(NSInteger)index;
@end
