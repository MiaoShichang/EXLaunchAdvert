//
//  EXLaunchUtils.m
//  EXLaunchDemo
//
//  Created by MiaoShichang on 2019/10/11.
//  Copyright © 2019 MiaoShichang. All rights reserved.
//

#import "EXLaunchUtils.h"


@implementation EXLaunchUtils


+ (UIImage *)LaunchScreenImage {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *launchScreen = infoDictionary[@"UILaunchStoryboardName"];
    NSArray *launchImages = infoDictionary[@"UILaunchImages"];
    
    // 获取APP初始化时显示LaunchStoryboard的屏幕截图
    if ([launchScreen isKindOfClass:NSString.class] && launchScreen.length > 0) {
        UIViewController *launchScreenController = [[UIStoryboard storyboardWithName:launchScreen bundle:nil] instantiateInitialViewController];
        if(launchScreenController) {
            UIGraphicsBeginImageContextWithOptions([UIScreen mainScreen].bounds.size, NO, [UIScreen mainScreen].scale);
            [launchScreenController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return resultImage;
        }
    }
    
    // 获取APP初始化时加载的LaunchImages中的图片
    if ([launchImages isKindOfClass:NSArray.class] && launchImages.count > 0) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        NSString *viewOrientation = @"Portrait"; //目前不支持横屏（Landscape）的情况
        for (NSDictionary* imageInfo in launchImages){
            CGSize imageSize = CGSizeFromString(imageInfo[@"UILaunchImageSize"]);
            if (CGSizeEqualToSize(imageSize, screenSize) &&
                [viewOrientation isEqualToString:imageInfo[@"UILaunchImageOrientation"]]){
                 NSString *imageName = imageInfo[@"UILaunchImageName"];
                if ([imageName isKindOfClass:NSString.class] && imageName.length > 0) {
                    return [UIImage imageNamed:imageName];
                }
            }
        }
    }
    
    return nil;
}



@end
