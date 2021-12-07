//
//  HomeViewController.m
//  Runner
//
//  Created by 何新涛 on 2021/5/11.
//  Copyright © 2021 The Chromium Authors. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.lightGrayColor;
    [self setupButton];
}

- (void)adjustFlutter {
    CGRect frame = self.flutterVC.view.frame;
    frame.size.width += 10.f;
    frame.size.height += 10.f;
    self.flutterVC.view.frame = frame;
}

- (void)setupButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.view addSubview:button];
    CGRect frame = button.frame;
    frame.origin.x = 200.f;
    frame.origin.y = 70.f;
    button.frame = frame;
    [button addTarget:self action:@selector(adjustFlutter) forControlEvents:UIControlEventTouchUpInside];
}


@end
