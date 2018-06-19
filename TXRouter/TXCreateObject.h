//
//  TXCreateObject.h
//  TXRouterDemo
//
//  Created by xtz_pioneer on 2018/6/14.
//  Copyright © 2018年 zhangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>

/*DEBUG 打印日志*/
#if DEBUG
#define TXCOLog(s, ... ) NSLog( @"<FileName:%@ InThe:%d Line> Log:%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define TXCOLog(s, ... )
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

@end
