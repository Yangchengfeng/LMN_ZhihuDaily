//
//  LaunchViewController.m
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/9.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "LaunchViewController.h"
#import "LaunchView.h"
#import "MainViewController.h"

@interface LaunchViewController ()

@property (nonatomic, strong) UIImageView *defaultView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) LaunchView *bottomView;

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kColorRGBA(26, 26, 26, 1);
    
    [self getContainerView];
    [self getDefaultView]; // 后加上去的视图在最上面，消失之后呈现底层视图
    [self changeLaunchView];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)getDefaultView {
    _defaultView = [[UIImageView alloc] init];
    [self.view addSubview:_defaultView];
    
    [_defaultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.top.equalTo(self.view.mas_top).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
    _defaultView.image = [UIImage imageNamed:@"Default"];
    
}

- (void)getContainerView {
    _containerView = [[UIView alloc] init];
    _containerView.alpha = 0.0f;
    [self.view addSubview:_containerView];
    
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.top.equalTo(self.view.mas_top).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
    _containerView.backgroundColor = kColorRGBA(26, 26, 26, 1);

    /**/
    _imgView = [[UIImageView alloc] init];
    _imgView.image = [UIImage imageNamed:@"Default"];
    [_containerView addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_containerView.mas_left);
        make.top.equalTo(_containerView.mas_top);
        make.width.equalTo(_containerView.mas_width);
        make.height.equalTo(_containerView.mas_height).multipliedBy(0.85);
    }];
    
    /**/
     _bottomView = [[LaunchView alloc] initWithFrame:CGRectMake(0, kScreenHeight*0.85, kScreenWidth, kScreenHeight*0.15)];
    _bottomView.alpha = 0.0f;
    [_containerView addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_containerView.mas_left);
        make.right.equalTo(_containerView.mas_right);
        make.bottom.equalTo(_containerView.mas_bottom);
        make.top.equalTo(_imgView.mas_bottom);
    }];
}

- (void)changeLaunchView {
    [UIView animateWithDuration:2.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        NSURL *baseURL = [NSURL URLWithString:kLanuchVCURLStr];
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
        
        CGFloat screenScale = [UIScreen mainScreen].scale; // Retina与非Retina分辨率不同，需要的图片尺寸不一样,当然我这里不作为整屏幕，影响不大
        NSString *getStr = [NSString stringWithFormat:@"prefetch-launch-images/%ld*%ld", [@(kScreenWidth) integerValue]*(int)screenScale , [@(kScreenHeight) integerValue]*(int)screenScale];
        
        [manager GET:getStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSArray *creatives = responseObject[@"creatives"];
            if(creatives.count > 0) {
                NSDictionary *object = creatives.firstObject;
                NSURL *picURL = [NSURL URLWithString:object[@"url"]];
                [[SDWebImageManager sharedManager] downloadImageWithURL:picURL options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                    // 下载进度block
                } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    // 下载完成block
                    [_imgView setImage:image];
                }];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@", error);
        }];
        _defaultView.alpha = 0.0f;
        _containerView.alpha = 1.0f;
        _bottomView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        self.view.window.rootViewController = ((AppDelegate *)[UIApplication sharedApplication].delegate).mainViewController;
    }];
}

@end
