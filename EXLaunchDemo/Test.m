//
//  Test.m
//  EXLaunchDemo
//
//  Created by MiaoShichang on 2019/10/11.
//  Copyright © 2019 MiaoShichang. All rights reserved.
//

#import "Test.h"
#import "EXLaunchTimer.h"


@interface Test()

@property (nonatomic, strong) EXLaunchTimer *timer;

@end

@implementation Test

- (id)init
{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    
}

- (void)handle{
    NSLog(@"test handle");
}

@end
