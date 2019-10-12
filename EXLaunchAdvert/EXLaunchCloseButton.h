//
//  EXLaunchCloseButton.h
//  EXLaunchDemo
//
//  Created by MiaoShichang on 2019/10/11.
//  Copyright © 2019 MiaoShichang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EXLaunchCloseButtonEvent) {
    EXLaunchCloseButtonEventNone,
    EXLaunchCloseButtonEventClick,
    EXLaunchCloseButtonEventTimeout,
};

NS_ASSUME_NONNULL_BEGIN

@interface EXLaunchCloseButton : UIControl

@property (nonatomic, strong, readonly) UILabel *timeLabel;

@property (nonatomic, copy) void (^complete)(EXLaunchCloseButton *btn , EXLaunchCloseButtonEvent event);

- (void)startTimer:(NSInteger)duration;
@end

NS_ASSUME_NONNULL_END
