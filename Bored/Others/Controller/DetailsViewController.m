//
//  DetailsViewController.m
//  Bored
//
//  Created by lanou3g on 15/11/24.
//  Copyright © 2015年 何顺育. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView * webView;
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView = [[UIWebView alloc] init];
    self.webView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.webView];
    
    //适配屏幕大小
    self.webView.scalesPageToFit = YES;
    
    //设置代理
    self.webView.delegate = self;
 
    NSURL * url = [NSURL URLWithString:self.aStrurl];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    self.webView.scrollView.bounces = NO;
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
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
