//
//  AdvertManager.m
//  EXLaunchDemo
//
//  Created by MiaoShichang on 2019/10/12.
//  Copyright © 2019 MiaoShichang. All rights reserved.
//

#import "AdvertManager.h"
#import <UIKit/UIKit.h>
#import "EXLaunchManager.h"

#import "UIImageView+WebCache.h"


@interface AdvertManager () <EXLaunchManagerDelegate>

@property (nonatomic, assign) EXLaunchManager *launchManager;

@end


@implementation AdvertManager

+(void)load{
    [self manager];
}

+(AdvertManager *)manager{
    static AdvertManager *manager = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        manager = [[AdvertManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.launchManager = [EXLaunchManager manager];
        self.launchManager.delegate = self;
        
        // 注册系统通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidFinishLaunchingNotification:) name:UIApplicationDidFinishLaunchingNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForegroundNotification:) name:UIApplicationWillEnterForegroundNotification object:nil];
        
    }
    return self;
}

#pragma mark - 系统通知
// 启动APP时
- (void)applicationDidFinishLaunchingNotification:(NSNotification *)notification {

    [[EXLaunchManager manager] showWithAdvertId:nil];
}

// 从后台进入到前台, 可以在项目的任何地方调用 [[EXLaunchManager manager] showWithAdvertId:nil];随时加载广告
- (void)applicationWillEnterForegroundNotification:(NSNotification *)notification {
    
    [[EXLaunchManager manager] showWithAdvertId:nil];
}


#pragma mark - EXLaunchManagerDelegate
// 配置基本信息
- (void)launchManager:(EXLaunchManager *)manager config:(EXLaunchConfig *)config {
    config.waitAdvertTime = 3;
}

// 获取广告数据并配置
- (void)launchManager:(EXLaunchManager *)manager configAdvertBlcok:(void(^)(EXLaunchAdvert *_Nullable advert))configAdvert {
    
    // 网络请求广告数据，
    [self fecthAdverDateFormServreUrl:@"" success:^(DemoAdvertModel *advertModel) {
        // 请求成功
        
        // 图片广告
        EXLaunchImageAdvert *advert = [[EXLaunchImageAdvert alloc] init];
        advert.advertImageUrl = advertModel.advertImageUrl;
        // 广告在屏幕上显示的位置
        CGRect frame = [UIScreen mainScreen].bounds;
        frame.size.height = frame.size.height-200;
        advert.frame = frame;
        // 广告显示的时间
        advert.showTime = advertModel.showTime;
        // 添加额外数据
        advert.exData = advertModel;

        configAdvert(advert);
        
        // 自定义广告
//        EXLaunchCustomAdvert *advert = [[EXLaunchCustomAdvert alloc] init];
//        advert.showTime = 6;
//        advert.exData = advertModel;
//        configAdvert(advert);
        
    } failure:^(NSError *error) {
        ;
    }];
}
// 图片广告 -- 设置图片
- (void)launchManager:(EXLaunchManager *)manager loadAdvertImage:(UIImageView *)advertImageView advert:(nonnull EXLaunchImageAdvert *)advert {
    
    // 加载网络图片
//    NSURL *url = [NSURL URLWithString:advert.advertImageUrl];
//    [advertImageView sd_setImageWithURL:url];
    
    // 加载本地图片
    advertImageView.image = [UIImage imageNamed:@"1.jpg"];
    
    // 在此处也可以根据model信息 加载图片，例如：
//    if ([advert.exData isKindOfClass:DemoAdvertModel.class]) {
//        DemoAdvertModel *model = advert.exData;
//        if ([model.advertInfo isEqualToString:@"0"]) {
//            NSURL *url = [NSURL URLWithString:advert.advertImageUrl];
//            [advertImageView sd_setImageWithURL:url];
//        }
//        else if ([model.advertInfo isEqualToString:@"1"]) {
//            advertImageView.image = [UIImage imageNamed:@"1.jpg"];
//        }
//    }
}

// 自定义广告 -- 设置自定义广告视图,同时也要自己添加点击事件并自己处理事件
- (void)launchManager:(EXLaunchManager *)manager loadCustomAdvertOnView:(UIView *)contentView advert:(EXLaunchCustomAdvert *)advert {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:contentView.bounds];
    imageView.image = [UIImage imageNamed:@"2.jpg"];
    [contentView addSubview:imageView];
    
    UILabel *advertLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 300, contentView.bounds.size.width, 40)];
    advertLabel.font = [UIFont systemFontOfSize:20];
    advertLabel.textColor = [UIColor redColor];
    advertLabel.textAlignment = NSTextAlignmentCenter;
    advertLabel.text = @"这是自定义广告";
    [contentView addSubview:advertLabel];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 400, contentView.bounds.size.width, 44);
    [btn setTitle:@"查看详情" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [contentView addSubview:btn];
}

- (void)launchManager:(EXLaunchManager *)manager event:(EXLaunchEvent)event advert:(EXLaunchAdvert *)advert {
    NSLog(@"launchManager event");
    
}


#pragma mark -
- (void)btnClicked:(UIButton *)btn {
    [[EXLaunchManager manager] dismiss];
    
}


#pragma mark - 网络请求
/**
 *  此处模拟广告数据请求,实际项目中请做真实请求
 */
- (void)fecthAdverDateFormServreUrl:(NSString *)url success:(void (^)(DemoAdvertModel *advertModel))success failure:(void (^)(NSError *error))failure
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        DemoAdvertModel *model = [[DemoAdvertModel alloc] init];
        model.adverUrl = @"https://m.baidu.com";
        model.advertImageUrl = @"https://gss3.bdstatic.com/7Po3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike150%2C5%2C5%2C150%2C50/sign=c6c97b19cc5c10383073c690d378f876/9a504fc2d5628535ca44a9229aef76c6a7ef6308.jpg";
        model.advertInfo  = @"";
        model.showTime = 6;
        if(success) {
            success(model);
        }
    });
}

@end


@implementation DemoAdvertModel



@end
