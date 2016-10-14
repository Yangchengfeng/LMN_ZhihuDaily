//
//  CFBaseLogInOrOutViewController.m
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/21.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "CFBaseLogInOrOutViewController.h"
#import "MainViewController.h"

@implementation CFBaseLogInOrOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNaviBar]; // 添加导航栏
}

- (void)initNaviBar {
    UINavigationBar *naviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNaviBarHeight+20)];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 100, 25)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    _titleLabel.center = CGPointMake(kScreenWidth/2.0, 42);
    [naviBar addSubview:_titleLabel];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 7+20, 40, 30)];
    [btn setImage:[UIImage imageNamed:@"Login_Arrow"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"Login_Arrow_Highlight"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [naviBar addSubview:btn];
    
    [self.view addSubview:naviBar];
}

- (void)back {
    MainViewController *mainVC = [[MainViewController alloc] init];
    self.view.window.rootViewController = mainVC;
}

@end
