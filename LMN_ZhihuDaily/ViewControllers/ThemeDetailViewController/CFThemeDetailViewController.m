//
//  CFThemeDetailViewController.m
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/25.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "CFThemeDetailViewController.h"
#import "CFThemeDetailModel.h"
#import "CFThemeTableView.h"
#import "MainViewController.h"
#import "CFEditorsListTableViewController.h"
#import "HomeTableViewCell.h"
#import "CFNewNoPicCell.h"
#import "CFStoryModel.h"
#import "CFEditorsCell.h"
#import "UITableViewCell+CFTableViewCellTool.h"
#import "UIImage+CFImageTool.h"
#import "CFThemeDetailViewController.h"
#import "CFTopNewsViewController.h"

#define kNoPic 3

@interface CFThemeDetailViewController () <UITableViewDelegate, UITableViewDataSource>
{
    BOOL isAdd;
}

@property (nonatomic, strong) CFThemeTableView *newsListTableView;
@property (nonatomic, strong) CFThemeDetailModel *themeDetailModel;
@property (nonatomic, strong) UIButton *changeBtn;
@property (nonatomic, strong) UINavigationBar *naviBar;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CFThemeDetailViewController

- (void)setThemeID:(NSString *)themeID {
    _themeID = themeID;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    isAdd = YES;
    // Do any additional setup after loading the view.
    [self getInfo];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _newsListTableView = [[CFThemeTableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    _newsListTableView.delegate = self;
    _newsListTableView.dataSource = self;
    [self.view addSubview:_newsListTableView];
    
    [self initNavi];
}

- (void)initNavi {
    _naviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _naviBar.barTintColor = kColorRGBA(52, 185, 252, 1.0); // 更改导航栏颜色
    [self.view addSubview:_naviBar];
    
    // 标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    _titleLabel.font = [UIFont systemFontOfSize:18];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.center = CGPointMake(kScreenWidth/2.0, 42);
    [_naviBar addSubview:_titleLabel];
    
}


- (void)back:(id)sender {
    MainViewController *mainVC = [[MainViewController alloc] init];
    self.view.window.rootViewController = mainVC;
    [mainVC showMenuView];
}

#pragma mark - 获取该主题下的内容
- (void)getInfo {
    __weak typeof(self) weakSelf = self;
    
    NSMutableArray *storiesArr = [NSMutableArray array];
    NSMutableArray *authorArr = [NSMutableArray array];
    
    NSURL *baseURL = [NSURL URLWithString:kBaseURLStr];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    
    NSString *getURL = [NSString stringWithFormat:@"theme/%@", _themeID];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        
        [manager GET:getURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            
            _themeDetailModel = [CFThemeDetailModel themeDetailWithDict:responseObject];
            
            _titleLabel.text = _themeDetailModel.name; // 还没想到怎么样可以加在model里而不延迟
            
            NSURL *url = _themeDetailModel.background;
            for(NSDictionary *dict in _themeDetailModel.stories) {
                [storiesArr addObject:dict];
            }
            for(NSDictionary *dict in _themeDetailModel.editors) {
                [authorArr addObject:dict];
            }
        
            if(url == nil) {
                [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"AD_Icon"] forBarMetrics:UIBarMetricsDefault];
            } else {
                [[SDWebImageManager sharedManager] downloadImageWithURL:url options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                    // 下载进度block
                } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    // 下载完成block
                    
                    [_naviBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
                }];

            }
            
            // 返回按钮
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(8, 20, 44, 44)];
            [btn setImage:[UIImage imageNamed:@"Back_white"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
            [_naviBar addSubview:btn];
            
            // 是否关注按钮
            _changeBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-8-44, 20, 44, 44)];
            [_changeBtn setImage:[UIImage imageNamed:@"Management_Add"] forState:UIControlStateNormal];
            [_changeBtn addTarget:self action:@selector(addOrCancel:) forControlEvents:UIControlEventTouchUpInside];
            [_naviBar addSubview:_changeBtn];
            
            weakSelf.newsListTableView.dataDict = storiesArr;
            weakSelf.newsListTableView.authorArr = authorArr;
            
            [weakSelf.newsListTableView reloadData];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@", error);
        }];

        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.newsListTableView reloadData];
        });
    });
}

- (void)addOrCancel:(UIButton *)sender {
    isAdd = !isAdd; // 进行状态取反
    if(isAdd) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"取消关注"                                                                       message:nil
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [UIView animateWithDuration:0.1 animations:^{
            [self presentViewController:alert animated:YES completion:nil];
        } completion:^(BOOL finished) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        // 取消关注后按钮图片也会改变
        [_changeBtn setImage:[UIImage imageNamed:@"Management_Add"] forState:UIControlStateNormal];
    } else {
        [_changeBtn setImage:[UIImage imageNamed:@"Management_Cancel"] forState:UIControlStateNormal];
    }
}

// 返回每行高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0) {
        return 40;
    } else {
        return 95;
    }
}

// 返回每个分区行数
#pragma mark - 对tableView进行设置

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsListTableView.dataDict.count + 1; //包括主编
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(cell == nil) {
        
        if(indexPath.row == 0) {
            int count = (int)[self.newsListTableView.authorArr count];
            cell = [[CFEditorsCell alloc] init];
            for(int i = 0; i<count; i++) {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(64+30*i, 13, 20, 20)];
                NSURL *url = [_newsListTableView.authorArr[i] objectForKey:@"avatar"];
                [[SDWebImageManager sharedManager] downloadImageWithURL:url options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                    // 下载进度block
                } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    // 下载完成block
                    
                    [imageView setImage:[[UIImage compressImage:image toTargetWidth:20] circleImage]];
                }];
                
                [cell addSubview:imageView];
            }
            
        } else {
            if([_newsListTableView.dataDict[indexPath.row-1] count] == kNoPic) {
                cell = [[CFNewNoPicCell alloc] init];
                cell.content = [_newsListTableView.dataDict[indexPath.row-1] objectForKey:@"title"];
            } else {
                cell = [[HomeTableViewCell alloc] init];
                CFStoryModel *menuModel = [CFStoryModel storyWithDict:_newsListTableView.dataDict[indexPath.row-1]];
                cell.menuStoryModel = menuModel;
            }
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"点击行数%lu", indexPath.row);
    if(indexPath.row == 0) { // 跳转到主编首页
        CFEditorsListTableViewController *editorsListVC = [[CFEditorsListTableViewController alloc] initWithStyle:UITableViewStylePlain];
        editorsListVC.editors = _newsListTableView.authorArr;
        editorsListVC.themeID = _themeID;
        [self presentViewController:editorsListVC animated:YES completion:^{
        }];
    } else { // 跳转到对应新闻内容
        CFTopNewsViewController *slideStoryVC = [[CFTopNewsViewController alloc] init];
        CFStoryModel *storyModel = [CFStoryModel storyWithDict:_newsListTableView.dataDict[indexPath.row-1]];
        [slideStoryVC loadSlideStoryWithID:storyModel.ID];
        
        [self presentViewController:slideStoryVC animated:YES completion:^{
        }];
    }
}

@end
