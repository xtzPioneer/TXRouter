//
//  TXCreateObject.m
//  TXRouterDemo
//
//  Created by xtz_pioneer on 2018/6/14.
//  Copyright © 2018年 zhangxiong. All rights reserved.
//

#import "TXCreateObject.h"

/*解决在ARC模式下编译出了这个warning*/
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

/*类名Key*/
NSString * const classNameKey = @"className";

@implementation TXCreateObject

/**
 * 创建对象 (类方法)
 * @param className 类名字
 */
+ (void)createObjectWithClassName:(NSString *)className completionHandler:(TXCOCompletionHandler)completionHandler{
    if (!className || [className isEqualToString:@""]) {
        if (completionHandler) {
            NSString * message=@"参数“className”不能为空";
            completionHandler([NSError errorWithDomain:@"TXCreateObjectError" code:TXCOErrorTypeNoClassName userInfo:@{@"message":message}],nil);
        }
    }else{
        Class class = NSClassFromString(className);
        id obj = [[class alloc] init];
        if (!obj){
            if (completionHandler) {
                NSString * message=[NSString stringWithFormat:@"没有“%@”该类",className];
                completionHandler([NSError errorWithDomain:@"TXCreateObjectError" code:TXCOErrorTypeNoClass userInfo:@{@"message":message}],nil);
            }
        }else{
            if (completionHandler) completionHandler(nil,obj);
        }
    }
}
+ (id)createObjectWithClassName:(NSString *)className{
    __block id object = nil;
    [self createObjectWithClassName:className completionHandler:^(NSError *error, id obj) {
        object=obj;
        if (error) TXCOLog(@"%@",error.userInfo[@"message"]);
    }];
    return object;
}

/**
 * 创建对象 (类方法)
 * @param className 类名字
 * @param parameters 传递的参数
 */
+ (void)createObjectWithClassName:(NSString *)className parameters:(NSDictionary*)parameters completionHandler:(TXCOCompletionHandler)completionHandler{
    if (!className || [className isEqualToString:@""]) {
        if (completionHandler) {
            NSString * message=@"参数“className”不能为空";
            completionHandler([NSError errorWithDomain:@"TXCreateObjectError" code:-TXCOErrorTypeNoClassName userInfo:@{@"message":message}],nil);
        }
    }else if (!parameters){
        if (completionHandler) {
            NSString * message=@"参数“parameters”不能为空";
            completionHandler([NSError errorWithDomain:@"TXCreateObjectError" code:-TXCOErrorTypeNoParameters userInfo:@{@"message":message}],nil);
        }
    }else{
        id obj=[TXCreateObject createObjectWithClassName:className];
        if (!obj){
            if (completionHandler) {
                NSString * message=[NSString stringWithFormat:@"没有“%@”该类",className];
                completionHandler([NSError errorWithDomain:@"TXCreateObjectError" code:TXCOErrorTypeNoClass userInfo:@{@"message":message}],nil);
            }
        }else{
            SEL selector = NSSelectorFromString(@"initWithParameters:");
            if(![obj respondsToSelector:selector]){
                //如果没定义初始化参数方法，直接返回，没必要在往下做设置参数的方法
                if (completionHandler) {
                    NSString * message=[NSString stringWithFormat:@"%@该类未定义:%@方法",obj,@"initWithParameters:"];
                    completionHandler([NSError errorWithDomain:@"TXCreateObjectError" code:TXCOErrorTypeNoInitWithParametersMethod userInfo:@{@"message":message}],obj);
                }
            }
            //在初始化参数里面添加一个key信息，方便控制器中查验路由信息
            if(!parameters){
                parameters = [NSMutableDictionary dictionary];
                [parameters setValue:className forKey:classNameKey];
                SuppressPerformSelectorLeakWarning([obj performSelector:selector withObject:parameters]);
            }else{
                //注意:深拷贝和浅拷贝
                parameters=[parameters mutableCopy];
                [parameters setValue:className forKey:classNameKey];
                SuppressPerformSelectorLeakWarning( [obj performSelector:selector withObject:parameters]);
            }
            if (completionHandler) completionHandler(nil,obj);
        }
    }
}
+ (id)createObjectWithClassName:(NSString *)className parameters:(NSDictionary*)parameters{
    __block id object = nil;
    [self createObjectWithClassName:className parameters:parameters completionHandler:^(NSError *error, id obj) {
        object=obj;
        if (error) TXCOLog(@"%@",error.userInfo[@"message"]);
    }];
    return object;
}

@end

