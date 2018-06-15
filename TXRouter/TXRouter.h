//
//  TXRouter.h
//  TXRouter
//
//  Created by xtz_pioneer on 2018/5/23.
//  Copyright © 2018年 zhangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TXCreateObject.h"
#import <UIKit/UIKit.h>

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


@end
