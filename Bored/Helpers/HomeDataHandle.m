//
//  HomeDataHandle.m
//  Bored
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 何顺育. All rights reserved.
//

#import "HomeDataHandle.h"

@interface HomeDataHandle ()

@property (nonatomic, strong)NSMutableArray * dataArray;

@end
@implementation HomeDataHandle
+ (HomeDataHandle *)defaultDataHandle
{
    static dispatch_once_t onceToken;
    static HomeDataHandle * handle = nil;
    dispatch_once(&onceToken, ^{
        handle = [[HomeDataHandle alloc] init];
        handle.dataArray = [NSMutableArray array];
        handle.HeaderArray = [NSMutableArray array];
        
    });
    return handle;
}
- (void)loadDataWithUrlstring:(NSString *)urlstring
{
    if (self.dataArray.count !=0) {
        [self.dataArray removeAllObjects];
    }
    if (self.HeaderArray.count != 0) {
        [self.HeaderArray removeAllObjects];
    }
    // 开辟一个子线程获取数据
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURLSession * session = [NSURLSession sharedSession];
        NSURL * url = [NSURL URLWithString:urlstring];
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
        NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data != nil) {
                NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                NSDictionary * dict = dic[@"response"];
                NSDictionary * headerDic = dict[@"banners"];
                NSArray * headerArr = headerDic[@"list"];
                for (NSDictionary * headDict in headerArr) {
                    [self.HeaderArray addObject:headDict];
                }
                NSDictionary * dictionary = dict[@"feeds"];
                NSArray * arr = dictionary[@"list"];
                for (NSDictionary * d in arr) {
                    Home * h = [[Home alloc] init];
                    [h setValuesForKeysWithDictionary:d];
                    if (h.designs.count == 0) {
                        if (h.type != nil) {
                            [self.dataArray addObject:h];
                        }
                        
                    }
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"finishData" object:nil];
                });
            }
            
        }];
        [task resume];
    });
}
//- (void)loadDataWithFootUrlstring:(NSString *)urlstring
//{
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSURLSession * session = [NSURLSession sharedSession];
//        NSURL * url = [NSURL URLWithString:urlstring];
//        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
//        NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//            if (data != nil) {
//                NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//                NSDictionary * dict = dic[@"data"];
//                
//                NSArray * array = dict[@"list"];
//                for (NSDictionary * dictionary in array) {
//                    
//                    List * l = [[List alloc] init];
//                    [l setValuesForKeysWithDictionary:dictionary];
//                    if (l.flag == nil) {
//                        if (l.pic != nil) {
//                            [self.dataArray addObject:l];
//                        }
//                        
//                        
//                    }
//                    
//                }
//                
//                
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"finishData" object:nil];
//                });
//            }else{
//                
//                
//            }
//            
//        }];
//        [task resume];
//    });
//    
//}

- (NSInteger)modelCount
{
    
    return self.dataArray.count;
}
-(Home *)modelWithIndex:(NSInteger)index
{
    return self.dataArray[index];
}
@end
