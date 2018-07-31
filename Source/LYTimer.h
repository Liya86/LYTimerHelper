//
//  LYTimer.h
//  LYTimerHelper
//
//  Created by Liya on 2017/6/12.
//  Copyright © 2017年 Liya. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LYTimerEvent;

@interface LYTimer : NSObject
@property (nonatomic, assign, readonly) NSTimeInterval interval;
@property (nonatomic, copy, readonly) NSString *key;
/**
 GCD 实现定时器
 
 @param interval 多久fire
 @return LYTimer
 */
+ (instancetype)timerWithInterval:(NSTimeInterval)interval;
+ (instancetype)defaultTimer;

/**
 CADisplayLink 实现定时器
 
 @param frameInterval 几桢刷新一次
 @return LYTimer
 */
+ (instancetype)displayLinkWithFrameInterval:(NSInteger)frameInterval;
+ (instancetype)defaultDisplayLink;

/**
 添加key对应的定时操作
 
 @param key 定时操作对应的key
 @param repeatNum 循环次数 （PS: -1 -- 无限循环）
 @param actionBlock fire时执行的代码块
 */
- (void)addTimerWith:(NSString *)key repeatNum:(NSInteger)repeatNum withActionBlock:(void (^)(LYTimerEvent *event))actionBlock;
- (void)addTimerWith:(NSString *)key withActionBlock:(void (^)(LYTimerEvent *event))actionBlock;
- (void)addTimerForOnceWith:(NSString *)key withActionBlock:(void (^)(LYTimerEvent *event))actionBlock;

/**
 移除key对应的定时操作
 
 @param key 当前间隔定时器中要移除的定时操作对应的key值
 */
- (void)removeTimerForKey:(NSString *)key;

@end

@interface LYTimer (Deprecated)
/**
 添加key对应的定时操作
 
 @param block fire时执行的代码
 @param repeatNum 循环次数 （PS: -1 -- 无限循环）
 @param key 定时操作对应的key
 */
- (void)addTimerForBlock:(void (^)(LYTimerEvent *event))block repeatNum:(NSInteger)repeatNum key:(NSString *)key __deprecated_msg("使用 addTimerWith:repeatNum:withActionBlock:");
- (void)addTimerForBlock:(void (^)(LYTimerEvent *event))block key:(NSString *)key __deprecated_msg("使用 addTimerWith:withActionBlock:");
- (void)addTimerOnceForBlock:(void (^)(LYTimerEvent *event))block key:(NSString *)key __deprecated_msg("使用 addTimerForOnceWith:withActionBlock:");
@end

