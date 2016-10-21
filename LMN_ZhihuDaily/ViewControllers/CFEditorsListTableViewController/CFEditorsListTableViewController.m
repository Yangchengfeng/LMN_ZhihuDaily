//
//  CFEditorsListTableViewController.m
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/28.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "CFEditorsListTableViewController.h"
#import "CFThemeDetailViewController.h"
#import "UIImage+CFImageTool.h"
#import "CFEditorInfoViewController.h"

@interface CFEditorsListTableViewController ()

@end

@implementation CFEditorsListTableViewController

- (void)setEditors:(NSMutableArray *)editors {
    _editors = editors;
}

- (void)setThemeID:(NSString *)themeID {
    _themeID = themeID;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubView];
}

- (void)initSubView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 导航栏
    UINavigationBar *naviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, -64, kScreenWidth, 64)];
    naviBar.barTintColor = kColorRGBA(52, 185, 252, 1.0); // 更改导航栏颜色
    [self.view addSubview:naviBar];

    // 标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"主编";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(kScreenWidth/2.0, 42);
    [naviBar addSubview:titleLabel];
    
    // 返回按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(8, 22, 40, 40)];
    [btn setImage:[UIImage imageNamed:@"Back_white"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"Back_white"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [naviBar addSubview:btn];
    
    // 列表
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)back {
    NSLog(@"返回");
    CFThemeDetailViewController *themeDetailVC = [[CFThemeDetailViewController alloc] init];
    themeDetailVC.themeID = _themeID;
    self.view.window.rootViewController = themeDetailVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _editors.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

/*
 avatar = "http://pic2.zhimg.com/d3b31fa32_m.jpg";
 bio = "\U597d\U5947\U5fc3\U65e5\U62a5";
 id = 82;
 name = "\U9093\U82e5\U865a";
 url = "http://www.zhihu.com/people/deng-ruo-xu";
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        NSDictionary *dict = _editors[indexPath.row];
        
        // 头像
        NSURL *url = [NSURL URLWithString:[dict objectForKey:@"avatar"]];
        [[SDWebImageManager sharedManager] downloadImageWithURL:url options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            // 下载进度block
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            // 下载完成block
            
            [cell.imageView setImage:[[UIImage compressImage:image toTargetWidth:40] circleImage]];
        }];

        // 主标题
        cell.textLabel.text = [dict objectForKey:@"name"];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        // 子标题
        cell.detailTextLabel.text = [dict objectForKey:@"bio"];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 54.5, kScreenWidth, 0.5)];
    view.backgroundColor = [UIColor lightGrayColor];
    view.alpha = 0.15;
    [cell addSubview:view];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = _editors[indexPath.row];
    NSString *editorID = [dict objectForKey:@"id"];
    NSString *url = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/editor/%@/profile-page/ios", editorID];
    NSURL *editorUrl = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:editorUrl];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight)];
    [webView loadRequest:request];
    
    CFEditorInfoViewController *vc = [[CFEditorInfoViewController alloc] init];
    vc.editorName = [dict objectForKey:@"name"];
    [vc.view addSubview:webView];
    self.view.window.rootViewController = vc;
}

@end
