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

 @param block fire时执行的代码
 @param repeatNum 循环次数 （PS: -1 -- 无限循环）
 @param key 定时操作对应的key
 */
- (void)addTimerForBlock:(void (^)(LYTimerEvent *event))block repeatNum:(NSInteger)repeatNum key:(NSString *)key;
- (void)addTimerForBlock:(void (^)(LYTimerEvent *event))block key:(NSString *)key;
- (void)addTimerOnceForBlock:(void (^)(LYTimerEvent *event))block key:(NSString *)key;
- (void)removeTimerForKey:(NSString *)key;
@end

