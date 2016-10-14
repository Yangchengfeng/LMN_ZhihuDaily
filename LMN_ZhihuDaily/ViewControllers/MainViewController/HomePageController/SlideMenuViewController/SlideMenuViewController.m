//
//  SlideMenuViewController.m
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/11.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "SlideMenuViewController.h"
#import "CFLoginViewController.h"
#import "UIImage+CFImageTool.h"
#import "CFLogoutViewController.h"
#import "CFSettingsViewController.h"
#import "MainViewController.h"
#import "CFThemeDetailViewController.h"

@interface SlideMenuViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSInteger sumOfThemes;
}

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITableView *newsThemesTabelView; // 新闻主题界面
@property (nonatomic, strong) NSMutableArray *dataArr; // 可变数组存储新闻主题
@property (nonatomic, strong) NSMutableArray *newsIDArr; // 新闻的id

@end

@implementation SlideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArr = [[NSMutableArray alloc] init];
    _newsIDArr = [NSMutableArray array];
    self.view.backgroundColor = kColorRGBA(47, 51, 56, 1);
    
    _newsThemesTabelView.backgroundColor = [UIColor clearColor];
    [_newsThemesTabelView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _newsThemesTabelView.showsVerticalScrollIndicator = NO;
    _newsThemesTabelView.delegate = self;
    _newsThemesTabelView.dataSource = self;
    [_newsThemesTabelView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    
    [self loadNewsThemes];
    
}

#pragma mark - 获取个人信息到登录按钮

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshloginBtn];
}

- (void)refreshloginBtn {
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if([userDefault objectForKey:@"uid"]) {
        [_loginBtn setTitle:[userDefault objectForKey:@"username"] forState:UIControlStateNormal];
        NSURL *url = [NSURL URLWithString:[userDefault objectForKey:@"iconUrl"]];
        [[SDWebImageManager sharedManager] downloadImageWithURL:url options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            // 下载进度block
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            // 下载完成block
            
            [_loginBtn setImage:[[UIImage compressImage:image toTargetWidth:35] circleImage] forState:UIControlStateNormal];
        }];
    } else {
        UIImage *image = [UIImage imageNamed:@"Menu_Avatar"];
        [_loginBtn setTitle:@"请先登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:kColorRGBA(255, 255, 255, 0.5) forState:UIControlStateNormal];
        [_loginBtn setImage:[[UIImage compressImage:image toTargetWidth:35] circleImage] forState:UIControlStateNormal];
    }
    
}

#pragma mark - 获取新闻主题
- (void)loadNewsThemes {
    [_dataArr addObject:@"首页"]; // 添加首页
    [_newsIDArr addObject:@""]; // 添加首页的id
    
    NSURL *baseURL = [NSURL URLWithString:kBaseURLStr];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    
    [manager GET:@"themes" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
       
        id themes = responseObject[@"others"];
        sumOfThemes = [themes count]; // 获取新闻类型数
        
        NSLog(@"%@", themes);
        
        if([themes isKindOfClass:[NSArray class]]) {
            
            NSArray *newsThemes = (NSArray *)themes;
            for(NSDictionary *dict in newsThemes) {
                [_dataArr addObject:dict[@"name"]];
            }
            for (NSDictionary *dict in newsThemes) {
                [_newsIDArr addObject:dict[@"id"]];
            }

        } else {
            NSDictionary *newsThemes = (NSDictionary *)themes;
            [_dataArr addObject:newsThemes[@"name"]];
        }
        
        [_newsThemesTabelView reloadData];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [_newsThemesTabelView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}


#pragma mark - 设置tabelView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return sumOfThemes;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor blackColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", _dataArr[indexPath.row]];
    if(indexPath.row == 0) {
        [cell.imageView setImage:[UIImage imageNamed:@"Menu_Icon_Home"]];
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Menu_Enter"]];
    } else {
        [cell.imageView setImage:nil]; // 没有这句话会出现多拉几次tableView有的cell会出现Menu_Icon_Home，又因为有设置Menu_Follow，所以不会出现accessotyView也改了的情况
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Menu_Follow"]];
    }
    
    
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.textColor = kColorRGBA(255, 255, 255, 0.5);
    
    [cell.textLabel setHighlightedTextColor:[UIColor whiteColor]];
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark - 进行第三方登录
- (IBAction)login:(UIButton *)sender {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if([userDefault objectForKey:@"uid"]) {
        CFLogoutViewController *infoVC = [[CFLogoutViewController alloc] init];
        self.view.window.rootViewController = infoVC;
    } else {
        CFLoginViewController *loginVC = [[CFLoginViewController alloc] init];
        self.view.window.rootViewController = loginVC;
    }
}

#pragma mark - 设置
- (IBAction)settingsBtn:(id)sender {
    CFSettingsViewController *vc = [[CFSettingsViewController alloc] init];
    self.view.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath { // 不取消选中状态
    if(indexPath.row == 0) {
        MainViewController *mainVC = (MainViewController *)self.view.window.rootViewController;
        [mainVC showHomeView];
    } else {
        CFThemeDetailViewController *themeDetailVC = [[CFThemeDetailViewController alloc] init];
        themeDetailVC.themeID = _newsIDArr[indexPath.row];
        self.view.window.rootViewController = themeDetailVC;
//        UINavigationController *subNaviC = [[UINavigationController alloc] initWithRootViewController:themeDetailVC];
//        subNaviC.transitioningDelegate = (MainViewController *) self.view.window.rootViewController;
//        [self.view.window.rootViewController presentViewController:subNaviC animated:YES completion:nil];

    }
}

@end
