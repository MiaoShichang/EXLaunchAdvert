//
//  EXLaunchWindow.h
//  EXLaunchDemo
//
//  Created by MiaoShichang on 2019/10/12.
//  Copyright © 2019 MiaoShichang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXLaunchRootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EXLaunchWindow : NSObject

@property (nonatomic, assign) BOOL eanbleAdvert;

@property (nonatomic, assign, readonly) BOOL bShowing;

- (void)show;

- (void)dismiss;

- (void)configAdvert:(EXLaunchAdvert *)advert;

@end

NS_ASSUME_NONNULL_END
