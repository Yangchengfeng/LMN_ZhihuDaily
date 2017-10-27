//
//  CFLogoutViewController.m
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/21.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "CFLogoutViewController.h"
#import "MainViewController.h"
#import "UIImage+CFImageTool.h"

@interface CFLogoutViewController ()

@property (nonatomic, strong) UIImageView *imageView; // 头像
@property (nonatomic, strong) UILabel *label; // 用户名
@property (nonatomic, strong) UIButton *editBtn; // 修改用户名按钮
@property (nonatomic, strong) UIButton *logoutBtn; // 登出按钮

@end

@implementation CFLogoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"个人信息";
    
    [self showUserInfo];
}

- (void)showUserInfo {
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kNaviBarHeight+20, kScreenWidth, kScreenHeight-20-kNaviBarHeight)];
    [backgroundImageView setImage:[UIImage imageNamed:@"Login_Background"]];
    [self.view addSubview:backgroundImageView];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2.0 - 80, 150, 160, 160)];
    _imageView.layer.cornerRadius = 80;
    _imageView.layer.borderWidth = 1.0;
    _imageView.layer.borderColor = kColorRGBA(84, 143, 250, 0.8).CGColor;
    [self loadPic];
    [self.view addSubview:_imageView];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2.0 - 80, CGRectGetMaxY(_imageView.frame), 130, 30)];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    _label.textColor = [UIColor blackColor];
    _label.text = [userDefault objectForKey:@"username"];
    _label.textAlignment = NSTextAlignmentRight;
    _label.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_label];
    
    _editBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_label.frame), _label.frame.origin.y, 30, 30)];
    [_editBtn setImage:[UIImage imageNamed:@"Profile_Editname_Button"] forState:UIControlStateNormal];
    [_editBtn addTarget:self action:@selector(editName:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_editBtn];
    
    _logoutBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2.0-100, CGRectGetMaxY(_label.frame)+60, 200, 44)];
    _logoutBtn.userInteractionEnabled = YES;
    [_logoutBtn setImage:[UIImage imageWithResizableImageName:@"Profile_SignOut"]
 forState:UIControlStateNormal];
    [_logoutBtn setImage:[UIImage imageWithResizableImageName:@"Profile_SignOut_Highlight"] forState:UIControlStateHighlighted];
    [_logoutBtn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_logoutBtn];
    if([_label.text isEqualToString:@""] || _label.text == nil) {
        _logoutBtn.hidden = YES;
    }
}

#pragma mark - 修改用户名
- (void)editName:(UIButton *)editBtn {
    NSLog(@"修改图片");
}

#pragma mark - 获取图片
- (void)loadPic {
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSURL *url = [NSURL URLWithString:[userDefault objectForKey:@"iconUrl"]];
    NSString *uid = [userDefault objectForKey:@"uid"];
    if(!uid) {
        [_imageView setImage:[[UIImage imageNamed:@"Menu_Avatar"] circleImage]];
    } else {
        [[SDWebImageManager sharedManager] downloadImageWithURL:url options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            // 下载进度block
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            // 下载完成block
            [_imageView setImage:[image circleImage]];
        }];
    }
}

#pragma mark - 登出
- (void)logout {
    [UIView animateWithDuration:0.2 animations:^{
        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        indicatorView.center = CGPointMake(kScreenWidth/2.0, kScreenHeight/2.0);
        [self.view addSubview:indicatorView];
        
    } completion:^(BOOL finished) {
        [self resetDefaults];
        MainViewController *mainVC = [[MainViewController alloc] init];
        self.view.window.rootViewController = mainVC;
    }];
}

// 删除userDefault缓存
- (void)resetDefaults {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [userDefault dictionaryRepresentation];
    for (id key in dict) {
        [userDefault removeObjectForKey:key];
    }
    [userDefault synchronize];
}

@end
