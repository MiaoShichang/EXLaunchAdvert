//
//  EXLaunchAdvert.h
//  EXLaunchDemo
//
//  Created by MiaoShichang on 2019/10/12.
//  Copyright © 2019 MiaoShichang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/** 广告类型 */
typedef NS_ENUM(NSInteger , EXLaunchAdvertType) {
    EXLaunchAdvertTypeNone      = 0, // 无广告
    EXLaunchAdvertTypeImage     = 1, // 图片广告
    EXLaunchAdvertTypeCustom    = 2, // 自定义
};

NS_ASSUME_NONNULL_BEGIN

@interface EXLaunchAdvert : NSObject

@property (nonatomic, assign) EXLaunchAdvertType advertType;
// 广告显示时间
@property (nonatomic, assign) NSInteger showTime;

// 广告位置
@property (nonatomic, assign) CGRect frame;

// 附加自定义数据，自己处理使用
@property (nonatomic, strong) id exData; //

- (BOOL)isNone;
- (BOOL)isImageAdvert;
- (BOOL)isCustomAdvert;

@end



#pragma mark -
/** 图片广告 */
@interface  EXLaunchImageAdvert: EXLaunchAdvert


// 广告图片链接地址
@property (nonatomic, copy) NSString *advertImageUrl;

@end

/** 自定义广告 */
@interface  EXLaunchCustomAdvert: EXLaunchAdvert


@end




NS_ASSUME_NONNULL_END
