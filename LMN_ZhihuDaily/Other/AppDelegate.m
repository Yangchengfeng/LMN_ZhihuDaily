//
//  AppDelegate.m
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/9.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "AppDelegate.h"
#import "LaunchViewController.h"
// 第三方登录
#import <UMSocialCore/UMSocialCore.h>
#import <SMS_SDK/SMSSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds]; // 删除了main.storyboard,所以需要初始化
    
    LaunchViewController *vc = [[LaunchViewController alloc] init]; // 启动页
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self mainViewController];
    });
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:kUMAppKey];
    
    [self configUSharePlatforms];
    [self confitUShareSettings];

    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    // MOB
    [SMSSDK registerApp:@"1753f9c58ac8c"
             withSecret:@"fdd2bd1d27324b134aa9a58360282d48"];
    return YES;
}

- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

- (void)configUSharePlatforms
{
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:kSinaAppKey  appSecret:kSinaSecret redirectURL:kRedirectURL];
}

#pragma mark - 回调方法

// 注明：下面两种方法如果缺一个的话，当点击关闭按钮就会崩
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary*)options{
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

// 所有系统支持
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

#pragma mark - 初始化主界面控制器
- (MainViewController *)mainViewController {
    if (!_mainViewController) {
        _mainViewController = [[MainViewController alloc] init];
    }
    return _mainViewController;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
