//
//  EXLaunchWindow.m
//  EXLaunchDemo
//
//  Created by MiaoShichang on 2019/10/12.
//  Copyright © 2019 MiaoShichang. All rights reserved.
//

#import "EXLaunchWindow.h"
#import <UIKit/UIKit.h>
#import "EXLaunchTimer.h"
#import "EXLaunchMacro.h"
#import "EXLaunchManager.h"

@interface  EXLaunchWindow()

@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong) EXLaunchRootViewController *rootViewController;

@property (nonatomic, strong) EXLaunchTimer *waitTimer;

@property (nonatomic, strong) EXLaunchTimer *advertTimer;

@end

@implementation EXLaunchWindow

- (BOOL)bShowing {
    return self.window != nil;
}

- (void)show {
    if (self.bShowing) {
        return;
    }
    self.rootViewController = [[EXLaunchRootViewController alloc] init];
    @weakSelf(self);
    self.rootViewController.dismiss = ^(void) {
        @strongSelf(self);
        [self dismiss];
    };
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.rootViewController = self.rootViewController;
    window.windowLevel = UIWindowLevelStatusBar + 1;
    window.hidden = NO;
    window.alpha = 1;
    self.window = window;
    
    [self setupWaitTimer];
}

- (void)setupWaitTimer {
    self.eanbleAdvert = NO;
    if (self.waitTimer) {
        [self.waitTimer cancel];
        self.waitTimer = nil;
    }
    @weakSelf(self);
    self.waitTimer = [EXLaunchTimer timerWithInterval:0.2 withEventBlock:^(EXLaunchTimer * _Nonnull timer) {
        @strongSelf(self);
        if (self.eanbleAdvert) {
            [self.waitTimer cancel];
        }
        else {
            if (self.waitTimer.duration > [EXLaunchManager manager].config.waitAdvertTime) {
                [self.waitTimer cancel];
                [self dismiss];
            }
        }
    }];
    [self.waitTimer start];
}

- (void)configAdvert:(EXLaunchAdvert *)advert {
    if ([advert isNone]) {
        return;
    }
    [self.rootViewController configAdvert:advert];
    self.eanbleAdvert = YES;
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.window.alpha = 0;
    } completion:^(BOOL finished) {
        self.window = nil;
        self.rootViewController = nil;
    }];
}


@end
