//
//  LYTimerEvent.h
//  LYTimerHelper
//
//  Created by Liya on 2017/6/12.
//  Copyright © 2017年 Liya. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface LYTimerEvent : NSObject
@property (nonatomic, copy, readonly) void(^block)(void);
@property (nonatomic, copy, readonly) NSString *key;
/**
-1 -- 无限循环；
 5 -- 循环5次；
 0 -- 结束不循环了；
 */
@property (nonatomic, assign, readonly) NSInteger repeatNum;

- (instancetype)initWith:(void(^)(LYTimerEvent *event))eventBlock repeatNum:(NSInteger)repeatNum key:(NSString *)key;
- (instancetype)initWith:(void(^)(LYTimerEvent *event))eventBlock key:(NSString *)key;
- (instancetype)initOnceWith:(void(^)(LYTimerEvent *event))eventBlock key:(NSString *)key;
@end
