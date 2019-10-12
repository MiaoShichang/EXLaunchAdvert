//
//  EXLaunchManager.h
//  EXLaunchDemo
//
//  Created by MiaoShichang on 2019/10/11.
//  Copyright © 2019 MiaoShichang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXLaunchConfig.h"
#import "EXLaunchAdvert.h"


typedef NS_ENUM(NSInteger, EXLaunchEvent) {
    EXLaunchEventNone,
    EXLaunchEventTimeout, // 未设置广告window自动消失（timeForWaitAd时间用完了还没设置广告）
    EXLaunchEventClickCloseButton, //点击关闭按钮
    EXLaunchEventClickAdvert,  // 点击广告
    EXLaunchEventAdvertTimeOver, // 未点击广告，倒计时时间用完
};

NS_ASSUME_NONNULL_BEGIN

#pragma mark - EXLaunchManagerDelegate
@class EXLaunchManager;

@protocol EXLaunchManagerDelegate <NSObject>

@optional
#pragma mark - 数据源

- (void)launchManager:(EXLaunchManager *)manager config:(EXLaunchConfig *)config;

- (void)launchManager:(EXLaunchManager *)manager configAdvertBlcok:(void(^)(EXLaunchAdvert *_Nullable advert))configAdvert;

- (void)launchManager:(EXLaunchManager *)manager  loadAdvertImage:(UIImageView *)advertImageView advert:(EXLaunchImageAdvert *)advert;

- (void)launchManager:(EXLaunchManager *)manager  loadCustomAdvertOnView:(UIView *)contentView advert:(EXLaunchCustomAdvert *)advert;

#pragma mark - 事件
- (void)launchManager:(EXLaunchManager *)manager event:(EXLaunchEvent)event advert:(EXLaunchAdvert *)advert;

@end

#pragma mark - EXLaunchManager
@interface EXLaunchManager : NSObject

@property (nonatomic, strong, readonly) EXLaunchConfig *config;

@property (nonatomic, strong) id <EXLaunchManagerDelegate>delegate;


+ (instancetype)manager;

// advertId 是自己定义的数据自己处理（可能用到的地方是根据这个advertId加载不同的广告）
- (void)showWithAdvertId:(nullable NSString *)advertId;

- (void)dismiss;

@end




NS_ASSUME_NONNULL_END
