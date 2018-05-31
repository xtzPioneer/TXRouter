//
//  TXTest2ViewController.m
//  TXRouter
//
//  Created by xtz_pioneer on 2018/5/23.
//  Copyright © 2018年 zhangxiong. All rights reserved.
//

#import "TXTest2ViewController.h"

@interface TXTest2ViewController ()

@end

@implementation TXTest2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    CGFloat viewW=self.view.frame.size.width;
    CGFloat viewH=self.view.frame.size.height;
    
    CGFloat lableH=20;
    CGFloat lableX=20;
    CGFloat lableW=viewW-lableX*2;
    CGFloat lableY=(viewH-lableH)/2;
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(lableX, lableY, lableW, lableH)];
    lable.textAlignment=NSTextAlignmentCenter;
    lable.text = @"我是VC2";
    [self.view addSubview:lable];
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15, 44, 50, 20)];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    // Do any additional setup after loading the view.
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)initWithParameters:(NSDictionary *)parameters{
    self.title = [parameters objectForKey:@"title"];
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
