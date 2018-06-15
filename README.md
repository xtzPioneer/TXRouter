# TXRouter
* 轻量级组件化管理工具,让你轻轻松松添加自己的小组件.该工具原理简单、制作轻松、思路清晰等优点.

### TXRouter优点
* 比MGJRouter更加简单、使用更加方便 
* 原理简单、制作轻松、思路清晰

### TXModel缺点
* 不能高大上定义URL

### 代码片段
* TXCreateObject.h文件
```objc
/*DEBUG 打印日志*/
#if DEBUG
#define TXCOLog(s, ... ) NSLog( @"<FileName:%@ InThe:%d Line> Log:%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define TXCRLog(s, ... )
#endif

/*处理完成回调*/
typedef void (^TXCOCompletionHandler) (NSError *error,id obj);

/*错误代码*/
typedef NS_ENUM(NSInteger,TXCOErrorType){
    TXCOErrorTypeNoClassName  =-10000,//没有ClassName
    TXCOErrorTypeNoClass      =-10001,//没有该类
    TXCOErrorTypeNoParameters =-10002,//没有Parameters
    TXCOErrorTypeNoInitWithParametersMethod =-10003,//没有实现initWithParameters方法
};

@interface TXCreateObject : NSObject


/**
 * 创建对象
 * @param className 类名字
 */
+ (void)createObjectWithClassName:(NSString *)className completionHandler:(TXCOCompletionHandler)completionHandler;
+ (id)createObjectWithClassName:(NSString *)className;
/**
 * 创建对象
 * @param className 类名字
 * @param parameters 传递的参数
 * 注意:必须实现"initWithParameters:(NSDictionary*)parameters"该方法
 */
+ (void)createObjectWithClassName:(NSString *)className parameters:(NSDictionary*)parameters completionHandler:(TXCOCompletionHandler)completionHandler;
+ (id)createObjectWithClassName:(NSString *)className parameters:(NSDictionary*)parameters;
```
* TXRouter.h文件
```objc
/*处理完成回调*/
typedef void (^TXRCompletionHandler) (NSError *error,UIViewController * viewController);

/*错误代码*/
typedef NS_ENUM(NSInteger,TXRCErrorType){
    TXRCErrorTypeNoVCName=-100000,//没有vCName
    TXRCErrorTypeNoParameters=-100001,//没有parameters
    TXRCErrorTypeNoViewControllerOrNavigationControllerElement=-100002,//没有viewController或navigationController元素
    TXRCErrorTypeElementalAsymmetry=-100003,//元素不对称
};

@interface TXRouter : NSObject

/*路由管理器*/
+ (TXRouter*)routerManager;

/**
 * 创建视图控制器
 * @param vCName 类名字
 */
+ (void)createVCWithVCName:(NSString*)vCName completionHandler:(TXRCompletionHandler)completionHandler;
+ (UIViewController*)createVCWithVCName:(NSString*)vCName;

/**
 * 创建视图控制器
 * @param vCName 类名字
 * @param parameters 传递的参数
 * 注意:必须实现"initWithParameters:(NSDictionary*)parameters"该方法
 */
+ (void)createVCWithVCName:(NSString*)vCName parameters:(NSDictionary *)parameters completionHandler:(TXRCompletionHandler)completionHandler;
+ (UIViewController*)createVCWithVCName:(NSString*)vCName parameters:(NSDictionary *)parameters;


/**
 * 打开视图控制器
 * @param vCName 类名字
 * @param parameters 参数
 */
+ (void)openVC:(NSString*)vCName parameters:(NSDictionary *)parameters;

/**
 * 打开视图控制器
 * @param vCName 类名字
 * @param parameters 参数
 * @param completionHandler 完成回调
 */
+ (void)openVC:(NSString*)vCName parameters:(NSDictionary *)parameters completionHandler:(TXRCompletionHandler)completionHandler;
```

### 使用方法
* #import "TXRouter.h"

```objc
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
            [dic setValue:self.navigationController forKey:@"navigationController"];
            [TXRouter openVC:@"TXTest1ViewController" parameters:dic];
        }
            break;
        case 2:{
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:@"hello world" forKey:@"title"];
            [dic setValue:self forKey:@"viewController"];
            [TXRouter openVC:@"TXTest2ViewController" parameters:dic];
        }
            break;
        case 3:{
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
            [dic setValue:@"https://www.baidu.com" forKey:@"url"];
            [dic setValue:@"百度一下" forKey:@"title"];
            [dic setValue:self.navigationController forKey:@"navigationController"];
            [TXRouter openVC:@"TXTestWebViewController" parameters:dic completionHandler:^(NSError *error, UIViewController *viewController) {
                NSLog(@"error:%@---->:%@",error,viewController);
            }];
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
            [dic setValue:self.navigationController forKey:@"viewController"];
            [TXRouter openVC:@"TXTest3ViewController" parameters:dic];
            
        }
            break;
        case 4:{
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:self forKey:@"viewController"];
            [TXRouter openVC:@"测试" parameters:dic];
            
        }
        default:
            break;
    }
}
```
### 项目结构展示
<br /> ![image](https://github.com/xtzPioneer/TXRouter/raw/master/项目结构图.png)
### 效果展示
<br /> ![](https://github.com/xtzPioneer/TXRouter/raw/master/组件化管理工具.gif)



