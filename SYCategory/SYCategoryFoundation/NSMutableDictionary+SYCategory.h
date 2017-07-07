//
//  NSMutableDictionary+SYCategory.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 2017/7/6.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (SYCategory)

#pragma mark - 链式属性

/// 链式编程 添加，或重置元素（key不存在时新增，存在时修改）
- (NSMutableDictionary *(^)(id object, NSString *key))addObject;

/// 链式编程 删除指定元素
- (NSMutableDictionary *(^)(NSString *key))removeOjbectForKey;

/// 链式编程 删除所有元素
- (NSMutableDictionary *(^)())removeAllObject;

@end
