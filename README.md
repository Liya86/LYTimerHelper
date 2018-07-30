# LYTimerHelper
定时简易封装

* 引用
  pod 'LYTimerHelper'
  
* 使用  

  默认 1s 间隔的定时器
  
  ```
  //默认 1s 循环
  [[LYTimer defaultTimer] addTimerForBlock:^(LYTimerEvent *event){
        NSLog(@"timer_1");
    } key:@"timer_1"];

    // 循环1次
    [[LYTimer defaultTimer] addTimerOnceForBlock:^(LYTimerEvent *event){
        NSLog(@"timer_once_1");
    } key:@"timer_once_1"];
    
    // 循环5次
    [[LYTimer defaultTimer] addTimerForBlock:^(LYTimerEvent *event){
        NSLog(@"timer_repeat_5 = %ld", event.repeatNum);
    } repeatNum:5 key:@"timer_repeat_5"];
  ```
  
  3s 间隔的定时器
  
  ```
  [[LYTimer timerWithInterval:3] addTimerOnceForBlock:^(LYTimerEvent *event) {
        NSLog(@"timer_3");
    } key:@"timer_3"];
  ```
  
  1桢 间隔
  
  ```
  [[LYTimer defaultDisplayLink] addTimerForBlock:^(LYTimerEvent *event){
        NSLog(@"link_1");
    } key:@"link_1"];
    
    [[LYTimer defaultDisplayLink] addTimerOnceForBlock:^(LYTimerEvent *event){
        NSLog(@"link_once_1");
    } key:@"link_once_1"];
    
    [[LYTimer defaultDisplayLink] addTimerForBlock:^(LYTimerEvent *event){
        NSLog(@"link_repeat_5 = %ld", event.repeatNum);
    } repeatNum:5 key:@"link_repeat_5"];
    
  ```
  
  3桢 间隔
  
  ```
  [[LYTimer displayLinkWithFrameInterval:3] addTimerOnceForBlock:^(LYTimerEvent *event) {
        NSLog(@"link_3");
    } key:@"link_3"];
  ```