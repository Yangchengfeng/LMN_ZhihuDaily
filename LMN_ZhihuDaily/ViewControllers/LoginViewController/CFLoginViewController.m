//
//  CFLoginViewController.m
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/20.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "CFLoginViewController.h"
#import "MainViewController.h"
#import "SlideMenuViewController.h"
// 第三方登录
#import "UMSocialSnsPlatformManager.h"
#import "UMSocialAccountManager.h"
#import "CFRegViewController.h"

@interface CFLoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *zhihuLoginBtn;

@end

@implementation CFLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleLabel.text = @"登陆";
    [self initLogoImage];
    [self initLoginBtn];
}

- (void)initNaviBar {
    UINavigationBar *naviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kNaviBarHeight)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 25)];
    titleLabel.text = @"登陆";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.center = CGPointMake(kScreenWidth/2.0, 22);
    [naviBar addSubview:titleLabel];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(7, 5, 44, 40)];
    [btn setImage:[UIImage imageNamed:@"Back_white"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"Back_white"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [naviBar addSubview:btn];
    
    [self.view addSubview:naviBar];
}

- (void)initLogoImage {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 125, 45)];
    [imageView setImage:[UIImage imageNamed:@"Login_Logo"]];
    imageView.center = CGPointMake(kScreenWidth/2.0, 165);
    [self.view addSubview:imageView];
}

- (void)initLoginBtn {
    
    _zhihuLoginBtn.tag = 0;
    [_zhihuLoginBtn addTarget:self action:@selector(otherLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *weiboBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    weiboBtn.center = CGPointMake(kScreenWidth/2.0-8-15, kScreenHeight-75);
    [weiboBtn setImage:[UIImage imageNamed:@"Login_Btn_Weibo"] forState:UIControlStateNormal];
    weiboBtn.tag = 1;
    [weiboBtn addTarget:self action:@selector(otherLogin:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:weiboBtn];
    
    
    UIButton *tencentBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    tencentBtn.center = CGPointMake(kScreenWidth/2.0+8+15, kScreenHeight-75);
    [tencentBtn setImage:[UIImage imageNamed:@"Login_Btn_Tencent"] forState:UIControlStateNormal];
    tencentBtn.highlighted = NO;
    tencentBtn.tag = 2;
    [tencentBtn addTarget:self action:@selector(otherLogin:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:tencentBtn];
}

- (void)otherLogin:(UIButton *)loginBtn {
    if(loginBtn.tag == 0) {
        NSLog(@"短信验证码登陆");
    } else if(loginBtn.tag == 1){
        NSLog(@"微博登录");
    } else if(loginBtn.tag == 2) {
        NSLog(@"腾讯登陆");
    }
    switch(loginBtn.tag) {
        case 0: // 短信验证码登陆
            break;
        case 1: {// 微博登录
            
            UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
            snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) { //  获取微博用户名、uid、token等
                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
                    NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                    
                    // 添加到NSUserDefaults
                    NSString *uid = snsAccount.usid;
                    NSString *username = snsAccount.userName;
                    NSString *iconUrl = snsAccount.iconURL;
                    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                    [userDefault setObject:uid forKey:@"uid"];
                    [userDefault setObject:username forKey:@"username"];
                    [userDefault setObject:iconUrl forKey:@"iconUrl"];
                    
                    NSLog(@"=======%@", [userDefault objectForKey:@"uid"]);
                }});
            
            break;
        }
        case 2: // 腾讯登陆
            break;
    }
}

- (void)back {
    MainViewController *mainVC = [[MainViewController alloc] init];
    self.view.window.rootViewController = mainVC;
}
- (IBAction)messageLogin:(id)sender {
    CFRegViewController *reg = [[CFRegViewController alloc] init];
    [self presentViewController:reg animated:YES completion:^{
        
    }];
    NSLog(@"短信验证");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
