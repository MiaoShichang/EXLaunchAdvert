//
//  EXLaunchAdvert.m
//  EXLaunchDemo
//
//  Created by MiaoShichang on 2019/10/12.
//  Copyright © 2019 MiaoShichang. All rights reserved.
//

#import "EXLaunchAdvert.h"

@implementation EXLaunchAdvert

- (instancetype)init{
    self = [super init];
    if (self) {
        self.advertType = EXLaunchAdvertTypeNone;
    }
    return self;
}

- (BOOL)isNone {
    if ([self isImageAdvert] || [self isCustomAdvert]) {
        return NO;
    }
    return YES;
}

- (BOOL)isImageAdvert {
    return self.advertType == EXLaunchAdvertTypeImage;
}

- (BOOL)isCustomAdvert {
    return self.advertType == EXLaunchAdvertTypeCustom;
}

@end

#pragma mark - 图片广告
@implementation EXLaunchImageAdvert

- (instancetype)init{
    self = [super init];
    if (self) {
        self.advertType = EXLaunchAdvertTypeImage;
    }
    return self;
}

@end

#pragma mark - 自定义广告
@implementation EXLaunchCustomAdvert

- (instancetype)init {
    self = [super init];
    if (self) {
        self.advertType = EXLaunchAdvertTypeCustom;
    }
    return self;
}

@end

