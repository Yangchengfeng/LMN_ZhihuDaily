//
//  CFEditorInfoViewController.m
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/10/1.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "CFEditorInfoViewController.h"
#import "CFEditorsListTableViewController.h"

@interface CFEditorInfoViewController ()

@end

@implementation CFEditorInfoViewController

- (void)setEditorName:(NSString *)editorName {
    _editorName = editorName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 导航栏
    UINavigationBar *naviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    naviBar.userInteractionEnabled = YES;
    naviBar.barTintColor = kColorRGBA(52, 185, 252, 1.0); // 更改导航栏颜色
    [self.view addSubview:naviBar];
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = [NSString stringWithFormat:@"%@", _editorName];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(kScreenWidth/2.0, 42);
    [naviBar addSubview:titleLabel];
    
    // 返回按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(8, 22, 40, 40)];
    [btn setImage:[UIImage imageNamed:@"Back_white"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"Back_white"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(backEditors) forControlEvents:UIControlEventTouchUpInside];
    [naviBar addSubview:btn];

}

- (void)backEditors {
    NSLog(@"返回");
    [self.view removeFromSuperview];
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
