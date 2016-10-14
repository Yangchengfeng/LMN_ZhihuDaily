//
//  CarouselCollectionViewCell.m
//  HomeViewController
//
//  Created by 阳丞枫 on 16/9/16.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "CarouselCollectionViewCell.h"

@implementation CarouselCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
//        _newsImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kHomeTableViewRowHeight)];
//        _newsImage.backgroundColor = [UIColor lightGrayColor];
//        [self addSubview:_newsImage];
//        
//        _newsTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, kHomeTableViewRowHeight-100, [UIScreen mainScreen].bounds.size.width - 20, 80)];
//        _newsTitle.numberOfLines = 0;
//        [_newsTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:22]];
//        [_newsTitle setTextColor:[UIColor whiteColor]];
//        [self addSubview:_newsTitle];
//        
//        _carouselPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 80, 8)];
//        _carouselPageControl.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, kHomeTableViewRowHeight - 15);
//        _carouselPageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
//        _carouselPageControl.pageIndicatorTintColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.3];
//        [self addSubview:_carouselPageControl];

        
        _newsImage = ({
            UIImageView *imageView = [UIImageView new];
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.equalTo(self);
            }];
            imageView.backgroundColor = [UIColor lightGrayColor];
            imageView;
        });
        
        _carouselPageControl = ({
            UIPageControl *pageControl = [UIPageControl new];
            [self addSubview:pageControl];
            float margin = kScreenWidth/2.0 + 40;
            [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.offset(8);
                make.bottom.equalTo(self.mas_bottom).offset(-5);
                make.width.offset(80);
                make.left.equalTo(self.mas_right).offset(-margin);
            }];
            pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
            pageControl.pageIndicatorTintColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.3];
            pageControl;
        });
        
        _newsTitle = ({
            UILabel *label = [UILabel new];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).offset(16.f);
                make.right.equalTo(self.mas_right).offset(-16.f);
                make.bottom.equalTo(self.carouselPageControl.mas_top).offset(-4.f);
            }];
            label.preferredMaxLayoutWidth = kScreenWidth - 32; // 没有这句只能显示一行
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
            label.numberOfLines = 0;
            label;
        });

    }
    return self;
}

- (void)setTopStoryModel:(CFHomeStoryModel *)topStoryModel {
    if(topStoryModel == nil || [topStoryModel isEqual:@""]) {
        [_newsImage setImage:[UIImage imageNamed:@"topStories_placeholder"]];
        [_newsTitle setText:@" "];
    } else {
        _newsTitle.text = topStoryModel.title;
        [[SDWebImageManager sharedManager] downloadImageWithURL:topStoryModel.image options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            // 下载进度block
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            // 下载完成block
            [_newsImage setImage:[UIImage imageWithData:UIImageJPEGRepresentation(image, 0.8)]];
        }];
    }

}

@end
