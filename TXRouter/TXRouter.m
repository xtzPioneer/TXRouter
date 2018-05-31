//
//  TXRouter.m
//  TXRouter
//
//  Created by xtz_pioneer on 2018/5/23.
//  Copyright © 2018年 zhangxiong. All rights reserved.
//

#import "TXRouter.h"

/*DEBUG 打印日志*/
#if DEBUG
#define TXRLog(s, ... ) NSLog( @"<MemoryAddress:%p FileName:%@ InThe:%d Line> Log:%@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define TXLog(s, ... )
#endif

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
 * 创建对象 (对象方法)
 * @param className 类名字
 */
- (id)createObjectWithClassName:(NSString *)className{
    id obj = [TXRouter createObjectWithClassName:className];
    if (!obj) TXRLog(@"没有%@该类",className);
    return obj;
}

/**
 * 创建对象 (对象方法)
 * @param className 类名字
 * @param parameters 传递的参数
 */
- (id)createObjectWithClassName:(NSString *)className parameters:(NSDictionary*)parameters{
    id obj=[TXRouter createObjectWithClassName:className parameters:parameters];
    if (!obj) TXRLog(@"没有%@该类",className);
    return obj;
}


/**
 * 创建对象 (类方法)
 * @param className 类名字
 */
+ (id)createObjectWithClassName:(NSString *)className{
    Class class = NSClassFromString(className);
    id obj = [[class alloc] init];
    return obj;
}

/**
 * 创建对象 (类方法)
 * @param className 类名字
 * @param parameters 传递的参数
 */
+ (id)createObjectWithClassName:(NSString *)className parameters:(NSDictionary*)parameters{
    id obj=[TXRouter createObjectWithClassName:className];
    if (!obj) return obj;
    SEL selector = NSSelectorFromString(@"initWithParameters:");
    if(![obj respondsToSelector:selector]){
        //如果没定义初始化参数方法，直接返回，没必要在往下做设置参数的方法
        TXRLog(@"目标类:%@未定义:%@方法",obj,@"initWithParameters:");
        return obj;
    }
    //在初始化参数里面添加一个key信息，方便控制器中查验路由信息
    if(!parameters){
        parameters = [NSMutableDictionary dictionary];
        [parameters setValue:className forKey:classNameKey];
        SuppressPerformSelectorLeakWarning([obj performSelector:selector withObject:parameters]);
    }else{
        [parameters setValue:className forKey:classNameKey];
    }
    SuppressPerformSelectorLeakWarning( [obj performSelector:selector withObject:parameters]);
    return obj;
}
@end
