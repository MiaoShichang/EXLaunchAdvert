//
//  EXLaunchCloseButton.m
//  EXLaunchDemo
//
//  Created by MiaoShichang on 2019/10/11.
//  Copyright © 2019 MiaoShichang. All rights reserved.
//

#import "EXLaunchCloseButton.h"
#import "EXLaunchTimer.h"
#import "EXLaunchMacro.h"


@interface EXLaunchCloseButton ()

@property (nonatomic, strong, readwrite) UILabel *timeLabel;
@property (nonatomic, strong) CAShapeLayer *roundLayer;
@property (nonatomic, strong) EXLaunchTimer *titleTimer;
@property (nonatomic, strong) EXLaunchTimer *roundTimer;
//@property (nonatomic, assign) NSInteger counter;
@property (nonatomic, assign) NSInteger duration;

@end

@implementation EXLaunchCloseButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.timeLabel];
        [self.timeLabel.layer addSublayer:self.roundLayer];
        
//        [self startTimer:10];
        
        [self addTarget:self action:@selector(controlClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.timeLabel.frame = self.bounds;
    CGFloat width = self.timeLabel.frame.size.width;
    CGFloat height = self.timeLabel.frame.size.height;
    if (width > height) {
        self.timeLabel.layer.cornerRadius = height/2.0;
    }
    else {
        self.timeLabel.layer.cornerRadius = width/2.0;
    }
    
    self.roundLayer.frame = self.timeLabel.bounds;
    CGPoint centerPoint = CGPointMake(self.timeLabel.bounds.size.width/2.0, self.timeLabel.bounds.size.width/2.0);
    self.roundLayer.path = [UIBezierPath
                            bezierPathWithArcCenter:centerPoint
                            radius:self.timeLabel.bounds.size.width/2.0-1.0
                            startAngle:-0.5*M_PI
                            endAngle:1.5*M_PI
                            clockwise:YES
                            ].CGPath;
}

- (UILabel *)timeLabel {
    if(_timeLabel ==  nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        _timeLabel.layer.masksToBounds = YES;
        _timeLabel.text = @"";
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = [UIFont systemFontOfSize:13.5];
    }
    return _timeLabel;
}

- (CAShapeLayer *)roundLayer {
    if(_roundLayer==nil){
        _roundLayer = [CAShapeLayer layer];
        _roundLayer.fillColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0].CGColor;
        _roundLayer.strokeColor = [UIColor whiteColor].CGColor;
        _roundLayer.lineCap = kCALineCapRound;
        _roundLayer.lineJoin = kCALineJoinRound;
        _roundLayer.lineWidth = 2;
        _roundLayer.strokeStart = 0;
    }
    return _roundLayer;
}

- (void)startTimer:(NSInteger)duration {
    if (duration <= 0) {
        return;
    }
    self.duration = duration;
    self.timeLabel.text = [NSString stringWithFormat:@"%lds", (long)self.duration];
    
    // title 倒计时器
    @weakSelf(self);
    self.titleTimer = [EXLaunchTimer timerWithInterval:1 withEventBlock:^(EXLaunchTimer * _Nonnull timer) {
        @strongSelf(self);
        NSInteger counter = self.duration-timer.duration;
        if (counter < 0) {
            counter = 0;
            self.timeLabel.text = [NSString stringWithFormat:@"%lds", (long)counter];
            [self.titleTimer cancel];
            self.titleTimer = nil;
            [self handle];
        }
        else{
            self.timeLabel.text = [NSString stringWithFormat:@"%lds", (long)counter];
        }
    }];
    [self.titleTimer start];
    
    // 圆环进度计时器
    CGFloat interval = 0.05; // 进度间隔时间
    self.roundTimer = [EXLaunchTimer timerWithInterval:interval withEventBlock:^(EXLaunchTimer * _Nonnull timer) {
        @strongSelf(self);
        
        if (self.roundTimer.duration < self.duration) {
            self.roundLayer.strokeStart = self.roundTimer.duration / self.duration;
        }
        else {
            self.roundLayer.strokeStart = 1;
            [self.roundTimer cancel];
            self.roundTimer = nil;
        }
    }];
    [self.roundTimer start];
}

- (void)handle {
    if (self.complete) {
        self.complete(self, EXLaunchCloseButtonEventTimeout);
    }
}

- (void)controlClicked:(UIControl *)control {
    if (self.complete) {
        self.complete(self, EXLaunchCloseButtonEventClick);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
