//
//  CFTopNewsViewController.m
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/10/1.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "CFTopNewsViewController.h"
#import "MainViewController.h"
#import "CFTopNewsDetailModel.h"
#import "CFFootModel.h"
#import "CFShareView.h"

@interface CFTopNewsViewController () <UIScrollViewDelegate, UIWebViewDelegate>

@property (nonatomic, strong) CFTopNewsDetailModel *topNewsDetailModel;
@property (nonatomic, strong) CFFootModel *footModel;
@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *imageSourceLabel;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UILabel *voteLabel;
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) CFShareView *shareView;

@end

@implementation CFTopNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initsubView];
}

#pragma  mark - 初始化界面
- (void)initsubView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _footView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 44, kScreenWidth, 44)];
    _footView.backgroundColor = [UIColor whiteColor];
    
    // 分割线
    UIView *departView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    departView.backgroundColor = [UIColor lightGrayColor];
    departView.alpha = 0.15;
    [_footView addSubview:departView];
    
    // 五个图标
    for(int i = 0; i<5; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/5.0 * i, 2, kScreenWidth/5.0, 40)];
        btn.tag = i;
        
        switch (i) { // 通过修改文件名也可以
                
            case 0: {
                [btn setImage:[UIImage imageNamed:@"News_Navigation_Arrow"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"News_Navigation_Arrow_Highlight"] forState:UIControlStateHighlighted];
                [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
                break;
            }
            case 1: {
                [btn setImage:[UIImage imageNamed:@"News_Navigation_Next"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"News_Navigation_Next_Highlight"] forState:UIControlStateHighlighted];
                break;
            }
            case 2: {
                [btn setImage:[UIImage imageNamed:@"News_Navigation_Vote"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"News_Navigation_Voted"] forState:UIControlStateSelected];
                [btn addTarget:self action:@selector(vote:) forControlEvents:UIControlEventTouchUpInside];
                break;
            }
            case 3: {
                [btn setImage:[UIImage imageNamed:@"News_Navigation_Share"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"News_Navigation_Share_Highlight"] forState:UIControlStateHighlighted];
                [btn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
                break;
            }
            case 4: {
                [btn setImage:[UIImage imageNamed:@"News_Navigation_Comment"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"News_Navigation_Comment_Highlight"] forState:UIControlStateHighlighted];
                break;
            }
            default:
                break;
        }
        
        [_footView addSubview:btn];
    }
    
    [self.view addSubview:_footView];
    
    _webView = ({
        UIWebView *view = [UIWebView new];
        [self.view insertSubview:view atIndex:0];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.mas_topLayoutGuideBottom);
            make.bottom.equalTo(self.footView.mas_top);
        }];
        view.scrollView.delegate = self;
        view.scrollView.backgroundColor = [UIColor whiteColor];
        view.delegate = self;
        view;
    });
    
    _headView = ({
        UIView *view = [UIView new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(-(kScreenWidth-220.f)/2);
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo((kScreenWidth-(kScreenWidth-220.f)/2));
        }];
        view.clipsToBounds = YES;
        view;
    });
    
    _headImageView = ({
        UIImageView *view = [UIImageView new];
        [self.headView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.and.top.equalTo(self.headView);
            make.height.equalTo(self.view.mas_width);
        }];
        view;
    });
    
    _imageSourceLabel = ({
        UILabel* label = [UILabel new];
        [self.headView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.headView).offset(-16.f);
            make.bottom.equalTo(self.headView).offset(-8.f);
        }];
        label.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
        label.font = [UIFont systemFontOfSize:11];
        label;
    });
    
    _titleLabel = ({
        UILabel* label = [UILabel new];
        [self.headView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headView).offset(16.f);
            make.right.equalTo(self.headView).offset(-16.f);
            make.bottom.equalTo(self.imageSourceLabel.mas_top).offset(-4.f);
        }];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
        label.numberOfLines = 0;
        label;
    });

    _voteLabel = ({
        UILabel *label = [UILabel new];
        [self.footView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.footView).multipliedBy(0.25);
            make.width.equalTo(self.footView.mas_width).multipliedBy(0.1);
            make.height.equalTo(self.footView.mas_height).multipliedBy(0.62);
            make.left.equalTo(self.footView.mas_right).multipliedBy(0.5);
        }];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        label.alpha = 0.5;
        label.font = [UIFont systemFontOfSize:8];
        label;
    });

    _commentLabel = ({
        UILabel *label = [UILabel new];
        [self.footView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.footView).multipliedBy(0.25);
            make.width.equalTo(self.footView.mas_width).multipliedBy(0.1);
            make.height.equalTo(self.footView.mas_height).multipliedBy(0.62);
            make.left.equalTo(self.footView.mas_right).multipliedBy(0.88);
        }];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.alpha = 0.5;
        label.font = [UIFont systemFontOfSize:8];
        label;
    });

    _shareView = (CFShareView *)({
        UIView *view = [[CFShareView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight - kHomeTableViewRowHeight)];
        [self.view addSubview:view];
        view.backgroundColor = kColorRGBA(245, 245, 245, 1.0);
        view;
    });
}

- (void)reloadView {
    if(_topNewsDetailModel == nil) {
        _headImageView.image = [UIImage imageNamed:@"topStories_placeholder"];
    } else {
        _headImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_topNewsDetailModel.image]]];
        _imageSourceLabel.text = [NSString stringWithFormat:@"图片:%@", _topNewsDetailModel.image_source];
        _titleLabel.text = _topNewsDetailModel.title;
        [_webView loadHTMLString:[self htmlStr] baseURL:nil];
        
    }
}

- (void)reloadFootView {
    if(_footModel == nil) {
        _voteLabel.text = @"";
        _commentLabel.text = @"0";
    } else {
        NSString *vote = [NSString stringWithFormat:@"%@", _footModel.popularity];
        NSString *comment = [NSString stringWithFormat:@"%@", _footModel.comments];
        if([vote isEqualToString:@"(null)"]) {
            _voteLabel.text = @"";
        } else {
            _voteLabel.text = [NSString stringWithFormat:@"%@", _footModel.popularity];
        }
        if([comment isEqualToString:@"(null)"]) {
            _commentLabel.text = @"0";
        } else {
            _commentLabel.text = [NSString stringWithFormat:@"%@", _footModel.comments];
        }
    }

}

- (NSString *)htmlStr {
    return [NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" href=%@></head><body>%@</body></html>",_topNewsDetailModel.css[0], _topNewsDetailModel.body];
}


#pragma mark - 按钮对应的事件

// 返回
- (void)back {
    MainViewController *mainVC = [[MainViewController alloc] init];
    self.view.window.rootViewController = mainVC;
}

// 点赞
- (void)vote:(UIButton *)button { // 有网络的时候，点一次就加一次，没网络的时候会显示加一次，但是图标会返回原来的灰色图案，这里待改进
    button.selected = !button.selected;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/5.0 * 2, kScreenHeight-74, kScreenWidth/5.0, 30)];
    label.text = @"+1";
    label.textColor = kColorRGBA(52, 185, 252, 1.0);
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    [UIView animateWithDuration:0.5 animations:^{
        label.alpha = 0;
    } completion:^(BOOL finished) {
        // 将数据存储在数据库
    }];
}

// 分享
- (void)share {
    CGRect frame = CGRectMake(0, kHomeTableViewRowHeight, kScreenWidth, kScreenHeight - kHomeTableViewRowHeight);
    [UIView animateWithDuration:0.15 animations:^{
        _shareView.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGRect frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight - kHomeTableViewRowHeight);
    [UIView animateWithDuration:0.15 animations:^{
        _shareView.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 获取数据
- (void)loadTopNewsWithID:(NSString *)ID {
    
    __weak typeof(self) weakSelf = self;
    
    NSString *urlStr = [NSString stringWithFormat:@"news/%@", ID];
    NSURL *url = [NSURL URLWithString:kBaseURLStr];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    [manager GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        _topNewsDetailModel = [CFTopNewsDetailModel topNewsDetailModelWithDict:dict];
        
        [weakSelf reloadView];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];

    NSString *extraStr = [NSString stringWithFormat:@"story-extra/%@", ID];
    AFHTTPSessionManager *extroManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    [extroManager GET:extraStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        _footModel = [CFFootModel footModelWithDict:dict];
        NSLog(@"%@", _footModel.popularity);
        [weakSelf reloadFootView];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView { // 设置下拉位移
    CGFloat offSetY = scrollView.contentOffset.y;
    if (offSetY < 0.f) {
        if (offSetY > - 90.f) {
            [_headView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view).offset(-(kScreenWidth-220.f)/2-offSetY/2);
                make.height.mas_equalTo(kScreenWidth-(kScreenWidth-220.f)/2-offSetY/2);
            }];
            [super updateViewConstraints];
        }else {
            _webView.scrollView.contentOffset = CGPointMake(0.f, -90.f);
        }
        
    }else if (offSetY >= 0.f && offSetY <= 400.f){
        [_headView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(-(kScreenWidth-220.f)/2-offSetY);
        }];
        [super updateViewConstraints];
    }

}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
