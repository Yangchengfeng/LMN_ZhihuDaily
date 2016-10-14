//
//  HomePageViewController.m
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/10.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "HomePageViewController.h"
#import "CFHomeStoryModel.h"
#import "UINavigationBar+CFNavigationBarTool.h"

@interface HomePageViewController () <UIScrollViewDelegate>
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _homeTableView = [[HomeTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    [self.view addSubview:_homeTableView];
    self.view.backgroundColor = [UIColor orangeColor];
    [self configObserve];
    [self loadStories];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadStories];
}

- (void)configObserve {
    [self.homeTableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil]; // 使用kvo监听
}

#warning 待修改
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if ([object isEqual:self.homeTableView]) {
        if ([keyPath isEqualToString:@"contentOffset"]) {
            CGFloat offSetY = self.homeTableView.contentOffset.y;
        }
    }
}

- (void)dealloc {
    [self.homeTableView removeObserver:self forKeyPath:@"contentOffset"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 获取新闻
- (void)loadStories {
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableArray *topStoryArr = [NSMutableArray array];
    NSMutableArray *storyArr = [NSMutableArray array];
    
    NSURL *baseURL = [NSURL URLWithString:kBaseURLStr];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    [manager GET:@"news/latest" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        // 轮播器
        NSArray *topStories = responseObject[@"top_stories"];
        for(NSDictionary *dict in topStories) {
            CFHomeStoryModel *topStoryModel = [CFHomeStoryModel homeStoryWithDict:dict];
            [topStoryArr addObject:topStoryModel];
        }
        
        NSArray *stories = responseObject[@"stories"];
        for(NSDictionary *dict in stories) {
            CFHomeStoryModel *storyModel = [CFHomeStoryModel homeStoryWithDict:dict];
            [storyArr addObject:storyModel];
        }

        
        weakSelf.homeTableView.topStoryArr = topStoryArr;
        weakSelf.homeTableView.storyArr = storyArr;
        
        
        [weakSelf.homeTableView.carouselView reloadData];
        [weakSelf.homeTableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];

}

@end
