//
//  ViewController.m
//  RSBannerSample
//
//  Created by 叶晓冬 on 2017/4/9.
//  Copyright © 2017年 R0CKSTAR. All rights reserved.
//

#import "ViewController.h"
#import "RSBannerViewController.h"

@interface ViewController ()

@property (nonatomic, strong) RSBannerViewController *bannerViewController;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.bannerViewController = [RSBannerViewController new];
    self.bannerViewController.rollingInterval = 3;
    self.bannerViewController.rollingImages = @[@"a", @"b", @"c"];
    [self.bannerViewController startRolling];
    [self addChildViewController:self.bannerViewController];
    [self.view addSubview:self.bannerViewController.view];
    self.bannerViewController.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 200);
    self.bannerViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.bannerViewController didMoveToParentViewController:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
