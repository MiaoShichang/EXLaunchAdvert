//
//  AdvertManager.h
//  EXLaunchDemo
//
//  Created by MiaoShichang on 2019/10/12.
//  Copyright © 2019 MiaoShichang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdvertManager : NSObject

@end



@interface DemoAdvertModel : NSObject

@property (nonatomic, copy) NSString *advertImageUrl;
@property (nonatomic, copy) NSString *adverUrl;
@property (nonatomic, assign) NSInteger showTime;
@property (nonatomic, copy) NSString *advertInfo;

@end


NS_ASSUME_NONNULL_END
