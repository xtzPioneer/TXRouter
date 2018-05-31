//
//  TXTestWebViewController.m
//  TXRouter
//
//  Created by xtz_pioneer on 2018/5/23.
//  Copyright © 2018年 zhangxiong. All rights reserved.
//

#import "TXTestWebViewController.h"

@interface TXTestWebViewController ()

@end

@implementation TXTestWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.dict[@"title"];
    UIWebView * view = [[UIWebView alloc]initWithFrame:self.view.frame];
    [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.dict[@"url"]]]];
    [self.view addSubview:view];
}

- (void)initWithParameters:(NSDictionary *)parameters{
    NSLog(@"parameters:%@",parameters);
    _dict=parameters;
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
