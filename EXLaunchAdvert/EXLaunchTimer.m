//
//  EXLaunchTimer.m
//  EXLaunchDemo
//
//  Created by MiaoShichang on 2019/10/11.
//  Copyright © 2019 MiaoShichang. All rights reserved.
//

#import "EXLaunchTimer.h"
#import "EXLaunchMacro.h"

@interface EXLaunchTimer()
@property (nonatomic, assign) CFAbsoluteTime startTime;
@property (nonatomic, assign) CFAbsoluteTime enterForegroundTime;

@property (nonatomic, assign, readwrite) CGFloat duration; // timer 从开始启动到现在的持续时间
@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation EXLaunchTimer

- (id)init{
    if (self = [super init]) {
        self.interval = 1.0f;
    }
    return self;
}

+ (instancetype)timerWithInterval:(CGFloat)interval withEventBlock:(void (^)(EXLaunchTimer *timer))eventBlock{
    
    EXLaunchTimer *timer = [[EXLaunchTimer alloc] init];
    timer.interval = interval;
    timer.eventBlock = eventBlock;
    return timer;
}

- (void)start {
    
    if (self.timer) {
        [self cancel];
    }
    
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_timer(self.timer, dispatch_walltime(NULL, 0), self.interval * NSEC_PER_SEC, 0);
    
    @weakify(self)
    dispatch_source_set_event_handler(self.timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self)
            if (self.eventBlock) {
                CFAbsoluteTime current = CFAbsoluteTimeGetCurrent();
                self.duration = current - self.startTime;
                self.eventBlock(self);
            }
        });
    });
    
    dispatch_resume(self.timer);
    self.startTime = CFAbsoluteTimeGetCurrent();
}

- (void)cancel {
    if(self.timer){
        dispatch_source_cancel(self.timer);
        self.timer = nil;
        self.duration = 0.0;
        self.startTime = 0.0;
    }
}

- (void)dealloc{
    [self cancel];
}





@end
