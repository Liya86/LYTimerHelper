# LYTimerHelper
定时简易封装

* 引用
  pod 'LYTimerHelper'
  
* 使用  

  默认 1s 间隔的定时器
  
  ```
  //默认 1s 循环
  [[LYTimer defaultTimer] addTimerWith:@"timer_1" withActionBlock:^(LYTimerEvent *event) {
        NSLog(@"timer_1");
    }];

    // 循环1次
    [[LYTimer defaultTimer] addTimerForOnceWith:@"timer_once_1" withActionBlock:^(LYTimerEvent *event) {
        NSLog(@"timer_once_1");
    }];
    
    // 循环5次
    [[LYTimer defaultTimer] addTimerWith:@"timer_repeat_5" repeatNum:5 withActionBlock:^(LYTimerEvent *event) {
        NSLog(@"timer_repeat_5 = %ld", (long)event.repeatNum);
    }];
  ```
  
  3s 间隔的定时器
  
  ```
  [[LYTimer timerWithInterval:3] addTimerForOnceWith:@"timer_3" withActionBlock:^(LYTimerEvent *event) {
        NSLog(@"timer_3");
    }];
  ```
  
  1桢 间隔
  
  ```
  [[LYTimer defaultDisplayLink] addTimerWith:@"link_1" withActionBlock:^(LYTimerEvent *event) {
        NSLog(@"link_1");
    }];
    
    [[LYTimer defaultDisplayLink] addTimerForOnceWith:@"link_once_1" withActionBlock:^(LYTimerEvent *event) {
        NSLog(@"link_once_1");
    }];
    
    [[LYTimer defaultDisplayLink] addTimerWith:@"link_repeat_5" repeatNum:5 withActionBlock:^(LYTimerEvent *event) {
        NSLog(@"link_repeat_5 = %ld", (long)event.repeatNum);
    }];
    
  ```
  
  3桢 间隔
  
  ```
  [[LYTimer displayLinkWithFrameInterval:3] addTimerForOnceWith:@"link_3" withActionBlock:^(LYTimerEvent *event) {
        NSLog(@"link_3");
    }];
  ```

  移除

  ```
  [[LYTimer defaultTimer] removeTimerForKey:@"timer_1"];
  [[LYTimer defaultDisplayLink] removeTimerForKey:@"link_1"];
  ```