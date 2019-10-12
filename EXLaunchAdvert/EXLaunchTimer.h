//
//  EXLaunchTimer.h
//  EXLaunchDemo
//
//  Created by MiaoShichang on 2019/10/11.
//  Copyright © 2019 MiaoShichang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EXLaunchTimer : NSObject

@property (nonatomic, assign) CGFloat interval;
@property (nonatomic, assign, readonly) CGFloat duration; // timer 从开始启动到现在的持续时间
@property (nonatomic, copy) void (^eventBlock)(EXLaunchTimer *timer);

// 使用时注意时循环引用的问题
+ (instancetype)timerWithInterval:(CGFloat)interval withEventBlock:(void (^)(EXLaunchTimer *timer))eventBlock;

- (void)start;

- (void)cancel;

@end

NS_ASSUME_NONNULL_END
