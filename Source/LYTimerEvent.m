//
//  LYTimerEvent.m
//  LYTimerHelper
//
//  Created by Liya on 2017/6/12.
//  Copyright © 2017年 Liya. All rights reserved.
//

#import "LYTimerEvent.h"

@interface LYTimerEvent()
@property (nonatomic, copy) void(^block)(void);
@property (nonatomic, copy) NSString *key;
@property (nonatomic, assign) NSInteger repeatNum;
@end

@implementation LYTimerEvent
- (instancetype)initWith:(void(^)(LYTimerEvent *event))eventBlock repeatNum:(NSInteger)repeatNum key:(NSString *)key{
    if (self = [super init]) {
        if (repeatNum == 0 || eventBlock == nil) {
            self = nil;
            return nil;
        }
        __weak typeof(self) wSelf = self;
        _block = ^(void){
            __strong typeof(wSelf) sSelf = wSelf;
            if (eventBlock) {
                eventBlock(sSelf);
            }
            if (sSelf.repeatNum > 0) {
                sSelf.repeatNum--;
            }
        };
        _key = key;
        _repeatNum = repeatNum;
    }
    return self;
}

- (instancetype)initWith:(void(^)(LYTimerEvent *event))eventBlock key:(NSString *)key{
    return [self initWith:eventBlock repeatNum:-1 key:key];
}

- (instancetype)initOnceWith:(void(^)(LYTimerEvent *event))eventBlock key:(NSString *)key{
    return [self initWith:eventBlock repeatNum:1 key:key];
}
@end
