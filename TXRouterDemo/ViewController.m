//
//  ViewController.m
//  TXRouter
//
//  Created by xtz_pioneer on 2018/5/30.
//  Copyright © 2018年 zhangxiong. All rights reserved.
//

#import "ViewController.h"
#import "TXRouter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"TX路由工具";
    
    CGFloat viewW=self.view.frame.size.width;
    
    CGFloat spacing=20;
    CGFloat buttonH=30;
    CGFloat buttonX=spacing;
    CGFloat buttonW=viewW-buttonX*2;
    
    CGFloat button1Y=100;
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, button1Y, buttonW, buttonH)];
    [button1 setTitle:@"访问VC1" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button1.tag = 1;
    [button1 addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    CGFloat button2Y=CGRectGetMaxY(button1.frame)+spacing;
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, button2Y, buttonW, buttonH)];
    [button2 setTitle:@"访问VC2" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button2.tag = 2;
    [button2 addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    CGFloat button3Y=CGRectGetMaxY(button2.frame)+spacing;
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, button3Y, buttonW, buttonH)];
    [button3 setTitle:@"访问VC3(代码块传值)" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button3.tag = 5;
    [button3 addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    CGFloat butto3Y=CGRectGetMaxY(button3.frame)+spacing;
    UIButton *butto3 = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, butto3Y, buttonW, buttonH)];
    [butto3 setTitle:@"访问Web页面" forState:UIControlStateNormal];
    [butto3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    butto3.tag = 3;
    [butto3 addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:butto3];
    
    CGFloat button4Y=CGRectGetMaxY(butto3.frame)+spacing;
    UIButton *button4 = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, button4Y, buttonW, buttonH)];
    [button4 setTitle:@"访问未定义的页面" forState:UIControlStateNormal];
    [button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button4.tag = 4;
    [button4 addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)back:(UIButton *)btn{
    switch (btn.tag) {
        case 1:{
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:@"hello world" forKey:@"title"];
            [dic setValue:self.navigationController forKey:viewControllerKey];
            [TXRouter openVC:@"TXTest1ViewController" parameters:dic];
        }
            break;
        case 2:{
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:@"hello world" forKey:@"title"];
            [dic setValue:self forKey:viewControllerKey];
            [TXRouter openVC:@"TXTest2ViewController" parameters:dic];
        }
            break;
        case 3:{
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
            [dic setValue:@"https://www.baidu.com" forKey:@"url"];
            [dic setValue:@"百度一下" forKey:@"title"];
            [dic setValue:self.navigationController forKey:viewControllerKey];
            [TXRouter openVC:@"TXTestWebViewController" parameters:dic];
        }
            break;
        case 5:{
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            //声明代码块
            void (^textBlock) (NSString *msg);
            //可以将block加入字典，当做一个回调取值
            textBlock = ^(NSString *msg){
                [btn setTitle:[NSString stringWithFormat:@"访问VC3(%@)",msg] forState:UIControlStateNormal];
                NSLog(@"从VC3中获取的数据是===>%@",msg);
            };
            [dic setObject:textBlock forKey:@"block"];
            [dic setValue:self forKey:@"viewController"];
            [TXRouter openVC:@"TXTest3ViewController" parameters:dic completionHandler:^{
                NSLog(@"打开成功");
            }];
            
        }
            break;
        case 4:{
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:self forKey:@"viewController"];
            [TXRouter openVC:@"测试" parameters:dic completionHandler:^{
                NSLog(@"打开成功");
            }];
            
        }
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

