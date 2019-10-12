//
//  EXLaunchRootViewController.m
//  EXLaunchDemo
//
//  Created by MiaoShichang on 2019/10/11.
//  Copyright © 2019 MiaoShichang. All rights reserved.
//

#import "EXLaunchRootViewController.h"
#import "EXLaunchUtils.h"
#import "EXLaunchCloseButton.h"
#import "EXLaunchMacro.h"
#import "EXLaunchManager.h"

@interface EXLaunchRootViewController ()

@property (nonatomic, strong) UIImageView *bgImageViw;
// 广告内容显示层
@property (nonatomic, strong) UIView *contentView;
// 图片广告视图
@property (nonatomic, strong) UIImageView *imageAdvertView;
// 视频广告视图
@property (nonatomic, strong) UIView *videoAdvertView;

@property (nonatomic, strong) EXLaunchCloseButton *closeBtn;

@property (nonatomic, strong) EXLaunchAdvert *advert;

@end

@implementation EXLaunchRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置默认背景
    self.bgImageViw = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.bgImageViw];
    self.bgImageViw.image = [EXLaunchUtils LaunchScreenImage];
    
    // 广告所在的视图
    [self.view addSubview:self.contentView];
    
    // 添加关闭按钮
    self.closeBtn = [[EXLaunchCloseButton alloc] init];
    self.closeBtn.frame = CGRectMake(self.view.bounds.size.width-60, 64, 40, 40);
    [self.view addSubview:self.closeBtn];
    
    @weakify(self);
    self.closeBtn.complete = ^(EXLaunchCloseButton * _Nonnull btn, EXLaunchCloseButtonEvent event) {
        @strongify(self);
        if(event == EXLaunchCloseButtonEventClick){
            [self sendEvent:EXLaunchEventClickCloseButton];
        }
        else if(event == EXLaunchCloseButtonEventTimeout){
            [self sendEvent:EXLaunchEventAdvertTimeOver];
        }
        if (self.dismiss) {
            self.dismiss();
        }
    };
}

- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    }
    return _contentView;
}

- (void)tapEvent:(UITapGestureRecognizer *)tapGes {
    [self sendEvent:EXLaunchEventClickAdvert];
    if (self.dismiss) {
        self.dismiss();
    }
}

#pragma mark - 显示广告
- (void)configAdvert:(EXLaunchAdvert *)advert {
    if ([advert isImageAdvert]) {
        EXLaunchLog(@"图片广告");
        [self removeContentSubViews];
        
        self.imageAdvertView =  [[UIImageView alloc] initWithFrame:CGRectZero];
        self.imageAdvertView.userInteractionEnabled = YES;
        [self.contentView addSubview:self.imageAdvertView];
        
        //添加点击手势
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
        [self.imageAdvertView addGestureRecognizer:tapGes];
        
        self.imageAdvertView.frame = advert.frame;
        EXLaunchManager *manager = [EXLaunchManager manager];
        if ([manager.delegate respondsToSelector:@selector(launchManager:loadAdvertImage:advert:)]) {
            [manager.delegate launchManager:manager loadAdvertImage:self.imageAdvertView advert:(EXLaunchImageAdvert *)advert];
        }
        [self.closeBtn startTimer:advert.showTime];
    }
    else if([advert isCustomAdvert]) {
        EXLaunchLog(@"自定义广告");
        [self removeContentSubViews];
        [self.closeBtn startTimer:advert.showTime];
        EXLaunchManager *manager = [EXLaunchManager manager];
        if ([manager.delegate respondsToSelector:@selector(launchManager:loadCustomAdvertOnView:advert:)]) {
            [manager.delegate launchManager:manager loadCustomAdvertOnView:self.contentView advert:(EXLaunchCustomAdvert *)advert];
        }
    }
    else {
        EXLaunchLog(@"广告类型错误！");
    }
}

#pragma mark - help
- (void)removeContentSubViews {
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
}

- (void)sendEvent:(EXLaunchEvent)event {
    EXLaunchManager *manager = [EXLaunchManager manager];
    if ([manager.delegate respondsToSelector:@selector(launchManager:event:advert:)]) {
        [manager.delegate launchManager:manager event:event advert:self.advert];
    }
}

#pragma mark - 系统设置
- (BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (BOOL)prefersHomeIndicatorAutoHidden {
    return YES;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
