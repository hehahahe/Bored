//
//  HomeViewController.m
//  Bored
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 何顺育. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeDataHandle.h"
#import "HomeCollectionViewCellOne.h"
#import "HomeCollectionViewCellTwo.h"
#import "HomeCollectionViewCellThree.h"
#import "UIImageView+WebCache.h"
#import "SDCycleScrollView.h"
#import "DetailsViewController.h"

@interface HomeViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SDCycleScrollViewDelegate>
@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray * headerArray;
@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UIButton * button;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"蹲坑必备";
    self.headerArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    [self p_setupViews];
    [self p_makeData];
    
}
- (void)p_makeData
{
    [[HomeDataHandle defaultDataHandle] loadDataWithUrlstring:@"http://app.qdaily.com/app/homes/index/0.json"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishLoadData) name:@"finishData" object:nil];
}
- (void)finishLoadData
{
    [self.headerArray addObjectsFromArray:[HomeDataHandle defaultDataHandle].HeaderArray];
    NSArray *imagesURLStrings = @[self.headerArray[0][@"image"],self.headerArray[1][@"image"],self.headerArray[2][@"image"],self.headerArray[3][@"image"],self.headerArray[4][@"image"]];
    NSArray *titles = @[self.headerArray[0][@"post"][@"title"],self.headerArray[1][@"post"][@"title"],self.headerArray[2][@"post"][@"title"],self.headerArray[3][@"post"][@"title"], self.headerArray[4][@"post"][@"title"]];
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, -(self.view.frame.size.width - 5) * 3/5 - 5, self.view.frame.size.width, (self.view.frame.size.width - 5) * 3/5) imageURLStringsGroup:nil]; // 模拟网络延时情景
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.delegate = self;
    cycleScrollView2.dotColor = [UIColor yellowColor]; // 自定义分页控件小圆标颜色
    cycleScrollView2.placeholderImage = [UIImage imageNamed:@"placeholder"];
    cycleScrollView2.titlesGroup = titles;
    cycleScrollView2.autoScrollTimeInterval = 5.0;//滚动间隔时间
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView2.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    [self.view addSubview:cycleScrollView2];
    
    cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    
    [self.collectionView addSubview:cycleScrollView2];
    [self.collectionView reloadData];
    
}
- (void)p_setupViews
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
//    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.contentInset = UIEdgeInsetsMake((self.view.frame.size.width - 5) * 3/5 + 5, 0, 0, 0);
    [self.collectionView registerClass:[HomeCollectionViewCellOne class] forCellWithReuseIdentifier:@"cellOne"];
    [self.collectionView registerClass:[HomeCollectionViewCellTwo class] forCellWithReuseIdentifier:@"cellTwo"];
    [self.collectionView registerClass:[HomeCollectionViewCellThree class] forCellWithReuseIdentifier:@"cellThree"];
    
    
    self.button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.button.frame = CGRectMake(30, self.view.frame.size.height - 60, 30, 30);
    [self.button setBackgroundImage:[UIImage imageNamed:@"iconfont-shouyezuoshangchoutilan"] forState:(UIControlStateNormal)];
    self.button.layer.cornerRadius = 15;
    self.button.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [self.button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
    self.view1 = [[UIView alloc] initWithFrame:CGRectMake(-self.view.frame.size.width/2, 0, self.view.frame.size.width/2, self.view.frame.size.height)];
    self.view1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    [self.view addSubview:self.view1];
    
    UISwipeGestureRecognizer * swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    
    [self.view addGestureRecognizer:swipe];
    
    //属性
    //清扫方向
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    UISwipeGestureRecognizer * swipe2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe2Action:)];
    
    [self.view addGestureRecognizer:swipe2];
    
    //属性
    //清扫方向
    swipe2.direction = UISwipeGestureRecognizerDirectionLeft;
    
}
//打开抽屉
- (void)swipeAction:(UISwipeGestureRecognizer *)sender
{
    [UIView animateWithDuration:1.0f animations:^{
        self.view1.frame = CGRectMake(0, 0, self.view.frame.size.width/2, self.view.frame.size.height);
        self.button.frame = CGRectMake(30 + self.view.frame.size.width/2, self.view.frame.size.height - 60, 30, 30);
        [self.button setBackgroundImage:[UIImage imageNamed:@"iconfont-left"] forState:(UIControlStateNormal)];
        self.button.selected = YES;
        }];
}
//收回抽屉
- (void)swipe2Action:(UISwipeGestureRecognizer *)sender
{
    
        [UIView animateWithDuration:1.0f animations:^{
            self.view1.frame = CGRectMake(-self.view.frame.size.width/2, 0, self.view.frame.size.width/2, self.view.frame.size.height);
            self.button.frame = CGRectMake(30, self.view.frame.size.height - 60, 30, 30);
            [self.button setBackgroundImage:[UIImage imageNamed:@"iconfont-shouyezuoshangchoutilan"] forState:(UIControlStateNormal)];
            self.button.selected = NO;
    }];
        
}
//抽屉button
- (void)buttonClicked:(UIButton *)sender
{
    if (sender.selected) {
        [UIView animateWithDuration:1.0f animations:^{
        self.view1.frame = CGRectMake(-self.view.frame.size.width/2, 0, self.view.frame.size.width/2, self.view.frame.size.height);
            self.button.frame = CGRectMake(30, self.view.frame.size.height - 60, 30, 30);
            [self.button setBackgroundImage:[UIImage imageNamed:@"iconfont-shouyezuoshangchoutilan"] forState:(UIControlStateNormal)];
            sender.selected = NO;
        }];
        
    } else {
        [UIView animateWithDuration:1.0f animations:^{
        self.view1.frame = CGRectMake(0, 0, self.view.frame.size.width/2, self.view.frame.size.height);
        self.button.frame = CGRectMake(30 + self.view.frame.size.width/2, self.view.frame.size.height - 60, 30, 30);
            [self.button setBackgroundImage:[UIImage imageNamed:@"iconfont-left"] forState:(UIControlStateNormal)];
            sender.selected = YES;
        }];
    }
}
#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    DetailsViewController * detailVC = [[DetailsViewController alloc] init];
    
    switch (index) {
        case 0:
            detailVC.aStrurl = self.headerArray[0][@"post"][@"appview"];
            
            break;
        case 1:
            detailVC.aStrurl = self.headerArray[1][@"post"][@"appview"];
            break;
        case 2:
            detailVC.aStrurl = self.headerArray[2][@"post"][@"appview"];
            break;
        case 3:
            detailVC.aStrurl = self.headerArray[3][@"post"][@"appview"];
            break;
        case 4:
            
            detailVC.aStrurl = self.headerArray[4][@"post"][@"appview"];
            
        default:
            break;
    }
    [self showViewController:detailVC sender:nil];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Home * h = [[HomeDataHandle defaultDataHandle] modelWithIndex:indexPath.item];
    if ([h.type intValue] == 1) {
        return CGSizeMake((self.view.frame.size.width - 5)/2, (self.view.frame.size.width - 5)/2);
    }else if ([h.type intValue] == 2){
        return CGSizeMake(self.view.frame.size.width - 5, (self.view.frame.size.width - 5) * 3/5);
    }
    else{
        return CGSizeMake(self.view.frame.size.width - 5, (self.view.frame.size.width - 5) / 2);
    }
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[HomeDataHandle defaultDataHandle] modelCount];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    Home * h = [[HomeDataHandle defaultDataHandle] modelWithIndex:indexPath.item];
    if ([h.type intValue] == 1) {
        HomeCollectionViewCellOne * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellOne" forIndexPath:indexPath];
        [cell bindModel:h];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:h.image]];
        cell.label.text = h.post[@"title"];
        [cell.imv sd_setImageWithURL:h.post[@"category"][@"image_small"]];
        cell.l1.text = h.post[@"category"][@"title"];
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }else if ([h.type intValue] == 2){
        HomeCollectionViewCellTwo * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellTwo" forIndexPath:indexPath];
        [cell.imv sd_setImageWithURL:[NSURL URLWithString:h.image]];
        cell.titleLabel.text = h.post[@"title"];
        [cell.imv2 sd_setImageWithURL:h.post[@"category"][@"image_small"]];
        cell.l1.text = h.post[@"category"][@"title"];
        return cell;
    }else{
        
        HomeCollectionViewCellThree * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellThree" forIndexPath:indexPath];
        
        [cell.imv sd_setImageWithURL:[NSURL URLWithString:h.post[@"image"]]];
        cell.titleLabel.text = h.post[@"title"];
        [cell.imv2 sd_setImageWithURL:h.post[@"category"][@"image_small"]];
        cell.readnumLabel.text = h.post[@"description"];
        return cell;
    }
    
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Home * h = [[HomeDataHandle defaultDataHandle] modelWithIndex:indexPath.item];
    if (h.type == nil) {
        
    }else{
        DetailsViewController * detailVC = [[DetailsViewController alloc] init];
        detailVC.aStrurl = h.post[@"appview"];
        [self showViewController:detailVC sender:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
