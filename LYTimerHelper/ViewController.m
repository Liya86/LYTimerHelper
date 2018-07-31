//
//  ViewController.m
//  LYTimerHelper
//
//  Created by Liya on 2018/7/11.
//  Copyright © 2018年 Liya. All rights reserved.
//

#import "ViewController.h"
#import "LYTimer.h"
#import "LYTimerEvent.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[LYTimer defaultTimer] addTimerWith:@"timer_1" withActionBlock:^(LYTimerEvent *event) {
        NSLog(@"timer_1");
    }];

    [[LYTimer defaultTimer] addTimerForOnceWith:@"timer_once_1" withActionBlock:^(LYTimerEvent *event) {
        NSLog(@"timer_once_1");
    }];

    [[LYTimer defaultTimer] addTimerWith:@"timer_repeat_5" repeatNum:5 withActionBlock:^(LYTimerEvent *event) {
        NSLog(@"timer_repeat_5 = %ld", (long)event.repeatNum);
    }];
    
    [[LYTimer timerWithInterval:3] addTimerForOnceWith:@"timer_3" withActionBlock:^(LYTimerEvent *event) {
        NSLog(@"timer_3");
    }];
    
    [[LYTimer defaultDisplayLink] addTimerWith:@"link_1" withActionBlock:^(LYTimerEvent *event) {
        NSLog(@"link_1");
    }];
    
    [[LYTimer defaultDisplayLink] addTimerForOnceWith:@"link_once_1" withActionBlock:^(LYTimerEvent *event) {
        NSLog(@"link_once_1");
    }];

    [[LYTimer defaultDisplayLink] addTimerWith:@"link_repeat_5" repeatNum:5 withActionBlock:^(LYTimerEvent *event) {
        NSLog(@"link_repeat_5 = %ld", (long)event.repeatNum);
    }];

    [[LYTimer displayLinkWithFrameInterval:3] addTimerForOnceWith:@"link_3" withActionBlock:^(LYTimerEvent *event) {
        NSLog(@"link_3");
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[LYTimer defaultTimer] removeTimerForKey:@"timer_1"];
        [[LYTimer defaultDisplayLink] removeTimerForKey:@"link_1"];
    });
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
