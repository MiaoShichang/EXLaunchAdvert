//
//  EXLaunchManager.m
//  EXLaunchDemo
//
//  Created by MiaoShichang on 2019/10/11.
//  Copyright © 2019 MiaoShichang. All rights reserved.
//

#import "EXLaunchManager.h"
#import <UIKit/UIKit.h>
#import "EXLaunchMacro.h"
#import "EXLaunchWindow.h"

@interface EXLaunchManager ()
@property (nonatomic, strong, readwrite) EXLaunchConfig *config;
@property (nonatomic, strong) EXLaunchWindow *launchWindow;
@end

@implementation EXLaunchManager

+ (instancetype)manager {
    static EXLaunchManager *manager = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        manager = [[EXLaunchManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.launchWindow = [[EXLaunchWindow alloc] init];
    }
    return self;
}

- (EXLaunchConfig *)config {
    if (_config == nil) {
        _config = [[EXLaunchConfig alloc] init];
    }
    return _config;
}

- (void)showLaunchWindow {
    [self.launchWindow show];
}

- (void)setAdvert:(EXLaunchAdvert *)advert {
    [self.launchWindow configAdvert:advert];
}

- (void)showWithAdvertId:(NSString *)advertId {
    if (self.launchWindow.bShowing) {
        return;
    }
    
    [self.launchWindow show];
    
    self.config.advertId = advertId;
    if(self.delegate && [self.delegate respondsToSelector:@selector(launchManager:config:)]){
        [self.delegate launchManager:self  config:self.config];
    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(launchManager:configAdvertBlcok:)]){
        @weakify(self);
        [self.delegate launchManager:self configAdvertBlcok:^(EXLaunchAdvert * _Nonnull advert) {
            @strongify(self);
            [self setAdvert:advert];
        }];
    }
}

- (void)dismiss {
    [self.launchWindow dismiss];
}

@end
