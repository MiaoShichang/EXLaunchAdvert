//
//  EXLaunchConfig.h
//  EXLaunchDemo
//
//  Created by MiaoShichang on 2019/10/11.
//  Copyright © 2019 MiaoShichang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//
@interface EXLaunchConfig : NSObject

@property (nonatomic, copy) NSString *advertId;

//等待配置广告时间，如果在此时间内没有配置广告，开屏将消失
@property (nonatomic, assign) CGFloat waitAdvertTime;


@end









NS_ASSUME_NONNULL_END
