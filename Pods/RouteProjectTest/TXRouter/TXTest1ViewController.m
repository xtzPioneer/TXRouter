//
//  TXTest1ViewController.m
//  TXRouter
//
//  Created by xtz_pioneer on 2018/5/23.
//  Copyright © 2018年 zhangxiong. All rights reserved.
//

#import "TXTest1ViewController.h"

@interface TXTest1ViewController ()

@end

@implementation TXTest1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat viewW=self.view.frame.size.width;
    CGFloat viewH=self.view.frame.size.height;
    
    CGFloat lableH=20;
    CGFloat lableX=20;
    CGFloat lableW=viewW-lableX*2;
    CGFloat lableY=(viewH-lableH)/2;
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(lableX, lableY, lableW, lableH)];
    lable.textAlignment=NSTextAlignmentCenter;
    lable.text = self.titletext;
    [self.view addSubview:lable];
    self.view.backgroundColor = [UIColor orangeColor];
    
    // Do any additional setup after loading the view.
}

-(void)initWithParameters:(NSDictionary *)parameters{
    self.titletext = [parameters objectForKey:@"title"];
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
