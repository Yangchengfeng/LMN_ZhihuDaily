//
//  MainViewController.m
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/11.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "MainViewController.h"
#import "SlideMenuViewController.h"
#import "HomePageViewController.h"
#import "UINavigationBar+CFNavigationBarTool.h"

static const CGFloat kNavigationBarHeight = 64.f;

@interface MainViewController () <UIScrollViewDelegate>
{
    CGFloat panMarginX; // 手势滑动在x的偏移量
}

@property (nonatomic, strong) UINavigationBar *naviBar; // 添加导航栏
@property (nonatomic, strong) UIScrollView *backgroundView; // 添加一个scrollview
@property (nonatomic, strong) SlideMenuViewController *menuVC; // 菜单控制器
@property (nonatomic, strong) HomePageViewController *homeVC; // 主页控制器
@property (nonatomic, strong) UIView *homeView; // 主页
@property (nonatomic, strong) UIView *menuView; // 菜单
@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer; // 推出菜单点击手势
@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer; // 滑动手势

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    panMarginX = 0.f;
    
    // 背景scrollView
    _backgroundView = [[UIScrollView alloc] initWithFrame:CGRectMake(-kScreenWidth/3.0*2.0, 0, kScreenWidth/3.0*5.0, kScreenHeight)];
    _backgroundView.backgroundColor = [UIColor blueColor];
    _backgroundView.scrollEnabled = YES;
    _backgroundView.delegate = self;
    [self.view addSubview:_backgroundView];
    
    // 菜单界面
    _menuVC = [[SlideMenuViewController alloc] init];
    self.menuView = _menuVC.view;
    [_menuView setFrame:CGRectMake(0, 0, kScreenWidth/3.0*2.0, kScreenHeight)];
    [_backgroundView addSubview:_menuView];
    
    // 主界面(添加导航栏)
    _homeVC = [[HomePageViewController alloc] init];
    self.homeView = _homeVC.view;
    [_homeView setFrame:CGRectMake(CGRectGetMaxX(_menuView.frame), 0, kScreenWidth, kScreenHeight)];
    [_backgroundView addSubview:_homeView];
    _naviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavigationBarHeight)];
    [_naviBar cnSetBackgroundColor:[UIColor clearColor]];
    [_homeView addSubview:_naviBar];
#pragma mark - 手势
    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToShowHomeView)]; // 手势一(展示菜单界面再添加)
    _panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panToChangeView:)]; // 手势二(一直都存在)
    [_homeView addGestureRecognizer:_panRecognizer];
    
    // 左侧按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 25, 25)];
    [btn setImage:[UIImage imageNamed:@"Home_Icon"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"Home_Icon_Highlight"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(leftBtnToPullMenuView) forControlEvents:UIControlEventTouchUpInside];
    [_naviBar addSubview:btn];
    
    // 标题栏
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"今日新闻";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    [_naviBar addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make .top.equalTo(btn.mas_top).offset(0);
        make.bottom.equalTo(btn.mas_bottom).offset(0);
        make.width.mas_equalTo(150);
        make.centerX.equalTo(_homeView.mas_centerX).offset(0);
    }];
}

#pragma mark - 导航栏渐变处理
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    _naviBar.barStyle = UIBarStyleBlack; //导航栏的背景色是黑色, 字体为白色
    [_naviBar setShadowImage:[UIImage new]]; //用于去除导航栏的底线，也就是周围的边线
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_naviBar cnReset];
}

#pragma mark - 切换视图(主页和菜单)

- (void)leftBtnToPullMenuView {
    if(_backgroundView.frame.origin.x != 0) {
        [self showMenuView];
    }
}

- (void)tapToShowHomeView {
    [self showHomeView];
}

- (void)panToChangeView:(UIPanGestureRecognizer *)recongizer {
    CGFloat moveX = [recongizer translationInView:self.homeView].x;
    panMarginX = panMarginX + moveX;
    CGFloat percent = panMarginX/(kScreenWidth/3.0 * 2.0);
    if (percent >= 0 && percent <= 1) {
        _backgroundView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.0, 1.0), CGAffineTransformMakeTranslation(panMarginX, 0));
    }
    
    if (recongizer.state == UIGestureRecognizerStateEnded) {
        if (percent < 0.5) {
            [self showHomeView];
        }else {
            [self showMenuView];
        }
    }
    
    [recongizer setTranslation:CGPointZero inView:self.view];
}


- (void)showHomeView {
    CFLog(@"推出菜单");
    
    [UIView animateWithDuration:0.1 animations:^{
        _backgroundView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.0, 1.0), CGAffineTransformMakeTranslation(0, 0));
    } completion:^(BOOL finished) {
        [_homeView removeGestureRecognizer:_tapRecognizer]; // 移出手势,否则会出现主页查看不了新闻详情的bug
    }];
}

- (void)showMenuView {
    CFLog(@"拉取菜单");
    [UIView animateWithDuration:0.1 animations:^{
        _backgroundView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.0, 1.0), CGAffineTransformMakeTranslation(kScreenWidth/3.0*2.0, 0));
    } completion:^(BOOL finished) {
        [_homeView addGestureRecognizer:_tapRecognizer]; // 在这里才添加手势个人觉得比一开始更合理
    }];
}

#pragma mark - 设置最顶部为白色

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
