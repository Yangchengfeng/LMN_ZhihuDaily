//
//  CFShareView.m
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/10/4.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "CFShareView.h"
#import "CFShareCell.h"

#define kMarginX 10
#define kMarginY 10
#define kCountOne 8
#define kCountTwo 2

@interface CFShareView () <UIScrollViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *otherView; // 收藏或取消
@property (nonatomic, strong) UIScrollView *wayScrollView; // 分享方式选择
@property (nonatomic, strong) UIButton *collectionBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSArray *arr;

@end

@implementation CFShareView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    _arr = [NSArray arrayWithObjects:@"微信好友",
                                     @"微信朋友圈",
                                     @"QQ",
                                     @"新浪微博",
                                     @"复制链接",
                                     @"有道云笔记",
                                     @"印象笔记",
                                     @"腾讯微博",
                                     @"信息",
                                     @"Instapaper",
                                     nil];
    // 标题
    _titleLabel = ({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
        [self addSubview:label];
        label.text = @"分享这篇内容";
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label;
    });
    
    // 分享方式选择
    _wayScrollView = ({
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 35, kScreenWidth, (frame.size.height - 35)/5.0*3.0)];
        scrollView.contentSize = CGSizeMake(kScreenWidth*2, (frame.size.height - 35)/5.0*3.0);
        scrollView.delegate = self;
        [scrollView setPagingEnabled:YES];
        scrollView.scrollEnabled = YES;
        scrollView.userInteractionEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        
        // 设置
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, (frame.size.height - 35)/5.0*3.0)];
        view1.backgroundColor = [UIColor clearColor];
        
        UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, (frame.size.height - 35)/5.0*3.0)];
        view2.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:view1];
        [scrollView addSubview:view2];
        
        CGFloat kWidth = (view1.frame.size.width - kMarginX*3 - 17*2)/4.0;
        CGFloat kHeight = (view1.frame.size.height - kMarginY - 26)/2.0;

        for (int i = 0; i<_arr.count; i++) {
            CFShareCell *cell = [[CFShareCell alloc] initWithFrame:CGRectMake(17+i%4*(kWidth+kMarginX), (kMarginY+kHeight) *(i/4%2), kWidth, kHeight)];
            NSString *btnName = [NSString stringWithFormat:@"Share_%02d", i]; // 名称直接用nameChanger(meini)方便
            [cell.btn setImage:[UIImage imageNamed:btnName] forState:UIControlStateNormal];
            cell.btn.tag = i;
            cell.label.text = _arr[i];
            if(i < 8) {
                [view1 addSubview:cell];
            }
            if(i >= 8) {
                [view2 addSubview:cell];
            }
        }


        scrollView;
    });
    
    _pageControl = ({
        UIPageControl *pageControl = [UIPageControl new];
        [self addSubview:pageControl];
        pageControl.backgroundColor = [UIColor clearColor];
        pageControl.bounds = CGRectMake(0, 0, 100, 20);
        pageControl.center = CGPointMake(self.bounds.size.width / 2, self.wayScrollView.bounds.size.height-11+35);
        pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
        pageControl.pageIndicatorTintColor = kColorRGBA(180, 180, 180, 0.3);
        pageControl.numberOfPages = 2;
        pageControl.currentPage = 0;
        pageControl;
    });
    
    // 不分享选择
    _otherView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - (frame.size.height - 35)/5.0*2.0, kScreenWidth, (frame.size.height - 35)/5.0*2.0)];
        [self addSubview:view];
        view;
    });
    
    _collectionBtn = ({
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth-30, _otherView.frame.size.height/3.0)];
        [_otherView addSubview:btn];
        [btn setTitle:@"收藏" forState:UIWindowLevelNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIWindowLevelNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.backgroundColor = [UIColor whiteColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn;
    });
    
    _cancelBtn = ({
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(15, _otherView.frame.size.height/2.0, kScreenWidth-30, _otherView.frame.size.height/3.0)];
        [_otherView addSubview:btn];
        [btn setTitle:@"取消" forState:UIWindowLevelNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIWindowLevelNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.backgroundColor = [UIColor whiteColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });

    return self;
}

- (void)cancel {
    CGRect frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight - kHomeTableViewRowHeight);
    [UIView animateWithDuration:0.15 animations:^{
        self.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.pageControl.currentPage = scrollView.contentOffset.x/CGRectGetWidth(self.frame);
}

@end
