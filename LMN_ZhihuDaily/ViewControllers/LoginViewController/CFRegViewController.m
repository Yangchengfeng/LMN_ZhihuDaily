//
//  CFRegViewController.m
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/21.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "CFRegViewController.h"
#import "UIImage+CFImageTool.h"
#import <SMS_SDK/SMSSDK.h>
#import "CFLogoutViewController.h"

@interface CFRegViewController () <UITextFieldDelegate>

@property (nonnull, strong) UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;

@property (weak, nonatomic) IBOutlet UITextField *codesField;
@end

@implementation CFRegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleLabel.text = @"短信登陆";
    _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, kScreenHeight-150, kScreenWidth-100, 44)];
    _loginBtn.backgroundColor = [UIColor whiteColor];
    _loginBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(sendToMakeSure) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_loginBtn];
    
    _phoneNum.keyboardType = UIKeyboardTypeNumberPad;
    _codesField.keyboardType = UIKeyboardTypeNumberPad;
    // 为了可以退出键盘
    _codesField.delegate = self;
    _phoneNum.delegate = self;
}

- (void)sendToMakeSure {
    NSLog(@"匹配手机与验证码");
    
    if(_phoneNum.text.length == 11 && _codesField.text.length == 4) {
        [SMSSDK commitVerificationCode:_codesField.text phoneNumber:_phoneNum.text zone:@"86" result:^(NSError *error) {
            if (!error) {
                //验证成功后的回调；
                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                NSString *usid = _phoneNum.text;
                NSString *username = @"dearHost";
                NSString *iconUrl = @"http://www.hua.com/flower_picture/meiguihua/images/r11.jpg";
                [userDefault setObject:username forKey:@"username"];
                [userDefault setObject:usid forKey:@"uid"];
                [userDefault setObject:iconUrl forKey:@"iconUrl"];
                
                self.view.window.rootViewController = [[CFLogoutViewController alloc] init];
            } else {
                //验证失败后的回调；
                NSLog(@"%@, %@, %@", _phoneNum.text, _codesField.text, error);
            }  
        }];

    } else {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"请输入正确的手机号码和验证码"
                                                                       message:@"手机号为11位，验证码为4位"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];

    }
}

- (IBAction)sendSMS:(id)sender {
    /*Error Domain=commitVerificationCode Code=468 "(null)" UserInfo={commitVerificationCode=提交验证码错误**/
    
    
    if(_phoneNum.text.length != 11) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"请输入正确的手机号码"
                                                                       message:@"校正手机号为11位(不能有空格)"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        [self openCountdown:sender];
        
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phoneNum.text
                                       zone:@"86"
                           customIdentifier:nil
                                     result:^(NSError *error){
                                         if (!error){
                                             //发送验证码成功的回调；
                                         }
                                         else{
                                             //发送验证码失败的回调；如果你输入错误的手机号码或者任意数字，就会回调；
                                             NSLog(@"%@", error);
                                         }
                                     }];

    }
}

- (void)openCountdown:(UIButton *)btn{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [btn setTitle:@"  重新发送" forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:13];
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                btn.userInteractionEnabled = YES;
            });
            
        }else{
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                btn.titleLabel.font = [UIFont systemFontOfSize:13];
                [btn setTitle:[NSString stringWithFormat:@"%.2ds", seconds] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                btn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_phoneNum resignFirstResponder];
    [_codesField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_phoneNum endEditing:YES];
    [_codesField endEditing:YES];
    return YES;
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
