//
//  TXCreateObject.h
//  TXCreate
//
//  Created by xtz_pioneer on 2018/6/20.
//  Copyright © 2018年 zhangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXCreateObject : NSObject

/**
 * 创建对象
 * @param className 类名字
 */
+ (id)createObjectWithClassName:(NSString *)className;

/**
 * 创建对象
 * @param className 类名字
 * @param parameters 传递的参数
 * 注意:必须实现"initWithParameters:(NSDictionary*)parameters"该方法
 */
+ (id)createObjectWithClassName:(NSString *)className parameters:(NSDictionary*)parameters;
@end
