//
//  TXRouter.m
//  TXRouter
//
//  Created by xtz_pioneer on 2018/5/23.
//  Copyright © 2018年 zhangxiong. All rights reserved.
//

#import "TXRouter.h"
NSString * const rVC = @"viewController";
NSString * const rNavVC = @"navigationController";

@implementation TXRouter

/*路由管理器*/
+ (TXRouter*)routerManager{
    static TXRouter * routerManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        routerManager = [[super allocWithZone:nil] init];
    });
    return routerManager;
}

/**
 * 创建视图控制器
 * @param vCName 类名字
 */
- (void)createVCWithVCName:(NSString*)vCName completionHandler:(TXRCompletionHandler)completionHandler{
    [TXCreateObject createObjectWithClassName:vCName completionHandler:completionHandler];
}
+ (void)createVCWithVCName:(NSString*)vCName completionHandler:(TXRCompletionHandler)completionHandler{
    [[TXRouter routerManager] createVCWithVCName:vCName completionHandler:completionHandler];
}
+ (UIViewController*)createVCWithVCName:(NSString*)vCName{
    __block UIViewController * vc=nil;
    [TXRouter createVCWithVCName:vCName completionHandler:^(NSError *error, UIViewController *viewController) {
        vc=viewController;
        if (error) TXCOLog(@"%@",error.userInfo[@"message"]);
    }];
    return vc;
}

/**
 * 创建视图控制器
 * @param vCName 类名字
 * @param parameters 传递的参数
 * 注意:必须实现"initWithParameters:(NSDictionary*)parameters"该方法
 */
- (void)createVCWithVCName:(NSString*)vCName parameters:(NSDictionary *)parameters completionHandler:(TXRCompletionHandler)completionHandler{
    [TXCreateObject createObjectWithClassName:vCName parameters:parameters completionHandler:completionHandler];
}
+ (void)createVCWithVCName:(NSString*)vCName parameters:(NSDictionary *)parameters completionHandler:(TXRCompletionHandler)completionHandler{
    [[TXRouter routerManager] createVCWithVCName:vCName parameters:parameters completionHandler:completionHandler];
}
+ (UIViewController*)createVCWithVCName:(NSString*)vCName parameters:(NSDictionary *)parameters{
    __block UIViewController * vc=nil;
    [TXRouter createVCWithVCName:vCName parameters:parameters completionHandler:^(NSError *error, UIViewController *viewController) {
        vc=viewController;
        if (error) TXCOLog(@"%@",error.userInfo[@"message"]);
    }];
    return vc;
}

/**
 * 打开视图控制器
 * @param vCName 类名字
 * @param parameters 参数
 * @param completionHandler 完成回调
 */
- (void)openVC:(NSString*)vCName parameters:(NSDictionary *)parameters completionHandler:(TXRCompletionHandler)completionHandler{
    if (!vCName || [vCName isEqualToString:@""]) {
        NSString * message=@"参数\"vCName\"不能为空";
        if (completionHandler) completionHandler([NSError errorWithDomain:@"openVCError" code:TXRCErrorTypeNoVCName userInfo:@{@"message":message}],nil);
    }else if (!parameters || parameters.count==0){
        NSString * message=@"参数\"parameters\"不能为空";
        if (completionHandler) completionHandler([NSError errorWithDomain:@"openVCError" code:TXRCErrorTypeNoParameters userInfo:@{@"message":message}],nil);
    }else if (!parameters[rNavVC] && !parameters[rVC]){
        NSString * message=[NSString stringWithFormat:@"参数\"parameters\"中的元素\"%@\"不能为空或参数\"parameters\"中的元素\"%@\"不能为空",rNavVC,rVC];
        if (completionHandler) completionHandler([NSError errorWithDomain:@"openVCError" code:TXRCErrorTypeNoViewControllerOrNavigationControllerElement userInfo:@{@"message":message}],nil);
    }else{
        UIViewController * receiveViewController=nil;
        if ([parameters[rVC] isKindOfClass:[UIViewController class]]) {
            receiveViewController=parameters[rVC];
        }
        UINavigationController * receiveNavigationController=nil;
        if ([parameters[rNavVC] isKindOfClass:[UINavigationController class]]) {
            receiveNavigationController=parameters[rNavVC];
        }
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithDictionary:parameters];
        [dict removeObjectForKey:rVC];
        [dict removeObjectForKey:rNavVC];
        __block UIViewController * toViewController=nil;
        if (receiveNavigationController) {
            [TXRouter createVCWithVCName:vCName parameters:dict completionHandler:^(NSError *error, UIViewController *viewController) {
                if (error) {
                    if (completionHandler) completionHandler(error,viewController);
                }else{
                    toViewController=viewController;
                    if (toViewController) [receiveNavigationController pushViewController:toViewController animated:YES];
                    if (completionHandler) completionHandler(nil,toViewController);
                }
            }];

        }else if (receiveViewController){
            [TXRouter createVCWithVCName:vCName parameters:dict completionHandler:^(NSError *error, UIViewController *viewController) {
                if (error) {
                    if (completionHandler) completionHandler(error,viewController);
                }else{
                    toViewController=viewController;
                    if (toViewController) [receiveViewController presentViewController:toViewController animated:YES completion:nil];
                    if (completionHandler) completionHandler(nil,toViewController);
                }
            }];
        }else{
            NSString * message=[NSString stringWithFormat:@"参数\"parameters\"中的元素\"%@\"不是“UINavigationController”对象或参数\"parameters\"中的元素\"%@\"不是“UIViewController”对象",rNavVC,rVC];
            if (completionHandler) completionHandler([NSError errorWithDomain:@"openVCError" code:TXRCErrorTypeElementalAsymmetry userInfo:@{@"message":message}],nil);
        }
    }
}

+ (void)openVC:(NSString*)vCName parameters:(NSDictionary *)parameters{
    [[TXRouter routerManager] openVC:vCName parameters:parameters completionHandler:^(NSError *error, UIViewController *viewController) {
        if (error) TXCOLog(@"%@",error.userInfo[@"message"]);
    }];
}

+ (void)openVC:(NSString*)vCName parameters:(NSDictionary *)parameters completionHandler:(TXRCompletionHandler)completionHandler{
    [[TXRouter routerManager] openVC:vCName parameters:parameters completionHandler:completionHandler];
}

@end
