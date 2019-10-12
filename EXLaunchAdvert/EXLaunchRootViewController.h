//
//  EXLaunchRootViewController.h
//  EXLaunchDemo
//
//  Created by MiaoShichang on 2019/10/11.
//  Copyright © 2019 MiaoShichang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EXLaunchConfig.h"
#import "EXLaunchManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface EXLaunchRootViewController : UIViewController

// 窗口移除回调
@property (nonatomic, copy) void (^_Nonnull dismiss)(void);

- (void)configAdvert:(EXLaunchAdvert *)advert;

@end

NS_ASSUME_NONNULL_END
