//
//  ViewController.m
//  EXLaunchDemo
//
//  Created by MiaoShichang on 2019/10/11.
//  Copyright © 2019 MiaoShichang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor= [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    label.text = @"首页";
    label.textColor = [UIColor redColor];
    [self.view addSubview:label];
    
    NSDictionary *dict = [[NSBundle mainBundle] infoDictionary];
    NSLog(@"dict - %@", dict);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    imageView.backgroundColor = [UIColor orangeColor];
//    imageView.image = [UIImage imageNamed:@"LaunchImage"];
    imageView.image = [self getTheLaunchImage];
    [self.view addSubview:imageView];
}

- (UIImage *)getTheLaunchImage
{

CGSize viewSize = [UIScreen mainScreen].bounds.size;

NSString *viewOrientation = nil;

if (([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown) || ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait)) {

viewOrientation = @"Portrait";

} else {

viewOrientation = @"Landscape";

}

NSString *launchImage = nil;

NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];

for (NSDictionary* dict in imagesDict)

{

CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);

if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])

{

launchImage = dict[@"UILaunchImageName"];

}

}

return [UIImage imageNamed:launchImage];

}

@end
