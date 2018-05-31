//
//  TXRouter.h
//  TXRouter
//
//  Created by xtz_pioneer on 2018/5/23.
//  Copyright © 2018年 zhangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXRouter : NSObject

/*路由管理器*/
+ (TXRouter*)routerManager;

/**
 * 创建对象
 * @param className 类名字
 */
- (id)createObjectWithClassName:(NSString *)className;

/**
 * 创建对象
 * @param className 类名字
 * @param parameters 传递的参数
 */
- (id)createObjectWithClassName:(NSString *)className parameters:(NSDictionary*)parameters;

@end
