//
//  TXCreateObject.m
//  TXCreate
//
//  Created by xtz_pioneer on 2018/6/20.
//  Copyright © 2018年 zhangxiong. All rights reserved.
//

#import "TXCreateObject.h"
#import <objc/runtime.h>
/*参数Key*/
NSString * const classNameKey = @"className";
/*解决编译前出现warning*/
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)
/*DEBUG 打印日志*/
#if DEBUG
#define TXCOLog(s, ... ) NSLog( @"<FileName:%@ InThe:%d Line> Log:%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define TXCOLog(s, ... )
#endif

@implementation TXCreateObject

+ (id)createObjectWithClassName:(NSString *)className{
    Class class = NSClassFromString(className);
    id obj = [[class alloc] init];
    if (!obj) {
        NSString * message=[NSString stringWithFormat:@"未能找到“%@”该类",className];
        TXCOLog(@"%@",message);
    }
    return obj;
}

+ (id)createObjectWithClassName:(NSString *)className parameters:(NSDictionary*)parameters{
    id obj = [self createObjectWithClassName:className];
    if (!obj) return obj;
    SEL selector = NSSelectorFromString(@"initWithParameters:");
    if(![obj respondsToSelector:selector]){
        NSString * message=[NSString stringWithFormat:@"”%@“该类未实现:%@方法",className,@"initWithParameters:"];
        TXCOLog(@"%@",message);
        return obj;
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
        SuppressPerformSelectorLeakWarning([obj performSelector:selector withObject:parameters]);
    }
    return obj;
}
@end
