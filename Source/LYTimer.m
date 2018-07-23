//
//  LYTimer.m
//  LYTimerHelper
//
//  Created by Liya on 2017/6/12.
//  Copyright © 2017年 Liya. All rights reserved.
//

#import "LYTimer.h"
#import "LYTimerEvent.h"
#import <QuartzCore/CADisplayLink.h>

@interface LYTimer()
@property (nonatomic, strong) NSMutableDictionary *eventMutableDic;
@property (nonatomic, assign) NSTimeInterval interval;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, strong) id timer;//加入
@end

@interface LYDispatchTimer : LYTimer

@end

@interface LYDispalyLink : LYTimer

@end

@implementation LYTimer

/**
 存放时间控制：CADisplayLink, key值为 @“CADisplayLink”+num(整形)
 其他类型的Timer, key值为 时间 * 1000 的nsnumber
 
 @return NSMapTable
 */
+ (NSMapTable *)timerMapTable
{
    static NSMapTable *mapTable;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mapTable = [NSMapTable strongToWeakObjectsMapTable];
    });
    return mapTable;
}

+ (instancetype)timerWithInterval:(NSTimeInterval)interval {
    LYDispatchTimer *timer = [[LYDispatchTimer alloc] initWithTimerInterval:interval];
    return timer;
}

+ (instancetype)defaultTimer {
    LYDispatchTimer *timer = [self timerWithInterval:1];
    return timer;
}

+ (instancetype)displayLinkWithFrameInterval:(NSInteger)frameInterval {
    LYDispalyLink *link = [[LYDispalyLink alloc] initWithTimerInterval:frameInterval];
    return link;
}

+ (instancetype)defaultDisplayLink {
    return [self displayLinkWithFrameInterval:1];
}

- (instancetype)init {
    return [self initWithTimerInterval:1];
}

- (instancetype)initWithTimerInterval:(NSTimeInterval)interval {
    NSMapTable *mapTable = [LYTimer timerMapTable];
    @synchronized(mapTable) {
        NSString *key = [[self class] creatKey:interval] ?: @"";
        LYTimer *timer = [mapTable objectForKey:key];
        if (timer) {
            return timer;
        } else {
            if (self = [super init]) {
                _interval = interval;
                _eventMutableDic = [NSMutableDictionary dictionary];
                _key = key;
                [mapTable setObject:self forKey:key];
            }
            return self;
        }
    }
    
    
}

- (void)startTimer {
    if (_timer == nil && _eventMutableDic.count > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self startTimerInMain];
        });
    }
}

- (void)startTimerInMain {
    if (_timer == nil && _eventMutableDic.count > 0) {
        [self creatTimer];
    }
}

- (void)stopTimer {
    if (_timer && _eventMutableDic.count == 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self stopTimerInMain];
        });
    }
}

- (void)stopTimerInMain {
    if (_timer && _eventMutableDic.count == 0) {
        [self cancelTimer];
    }
}

- (void)dealloc {
    [_eventMutableDic removeAllObjects];
    [self cancelTimer];
}

#pragma mark - methods the subclasses need to inherit
- (void)creatTimer {
}

- (void)cancelTimer {
    
}

+ (NSString *)creatKey:(NSTimeInterval)interval {
    return @"";
}

#pragma mark - timer's fire action
- (void)timerEventRuning {
    @synchronized(self) {
        NSArray *events = _eventMutableDic.allValues;
        for (LYTimerEvent *timerEvent in events) {
            if (timerEvent.block) {
                timerEvent.block();
            }
            if (timerEvent.repeatNum == 0) {
                [_eventMutableDic removeObjectForKey:timerEvent.key];
            }
        }
        [self stopTimer];
    }
}

- (void)addTimerForBlock:(void (^)(LYTimerEvent *event))block repeatNum:(NSInteger)repeatNum key:(NSString *)key {
    if (block && key && repeatNum != 0) {
        @synchronized(self) {
            LYTimerEvent *timerEvent = [[LYTimerEvent alloc] initWith:block repeatNum:repeatNum key:key];
            _eventMutableDic[key] = timerEvent;
            [self startTimer];
        }
    }
}

- (void)addTimerForBlock:(void (^)(LYTimerEvent *event))block key:(NSString *)key {
    [self addTimerForBlock:block repeatNum:-1 key:key];
}

- (void)addTimerOnceForBlock:(void (^)(LYTimerEvent *event))block key:(NSString *)key {
    [self addTimerForBlock:block repeatNum:1 key:key];
}

- (void)removeTimerForKey:(NSString *)key {
    if (key) {
        @synchronized(self) {
            [_eventMutableDic removeObjectForKey:key];
        }
    }
}
@end

@implementation LYDispatchTimer
- (void)creatTimer {
    // 1. 创建 dispatch source，并指定检测事件为定时
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    // 2. 设置定时器启动时间，间隔，容差
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, self.interval * NSEC_PER_SEC,  0 * NSEC_PER_SEC);
    // 3. 设置callback
    dispatch_source_set_event_handler(self.timer, ^{
        [self timerEventRuning];
    });
    // 4.启动定时器-刚创建的source处于被挂起状态
    dispatch_resume(self.timer);
   // dispatch_activate(self.timer); 10.0之后
}

- (void)cancelTimer {
    if (self.timer) {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
}

+ (NSString *)creatKey:(NSTimeInterval)interval {
    return [NSString stringWithFormat:@"Timer_%ld", (NSInteger)(interval * 1000)];
}

@end

@implementation LYDispalyLink
- (void)creatTimer {
    // 1.初始化
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(timerEventRuning)];
    // 2. 设置 - 2桢回调一次，这里非时间，而是以桢为单位
    NSInteger interval = (NSInteger)self.interval;
    displayLink.frameInterval = interval; //iOS10之前
    //displayLink.preferredFramesPerSecond = 60 / (interval?:1); //iOS10及之后
    // 3.加入RunLoop
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    self.timer = displayLink;
}

- (void)cancelTimer {
    if (self.timer) {
        // 1.暂停
        ((CADisplayLink *)self.timer).paused = YES;
        // 2.销毁
        [self.timer invalidate];
        self.timer = nil;
    }
}

+ (NSString *)creatKey:(NSTimeInterval)interval {
    return [NSString stringWithFormat:@"DisplayLink_%ld", (NSInteger)(interval)];
}

@end
