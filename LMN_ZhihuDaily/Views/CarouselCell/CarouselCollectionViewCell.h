//
//  CarouselCollectionViewCell.h
//  HomeViewController
//
//  Created by 阳丞枫 on 16/9/16.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFHomeStoryModel.h"

@interface CarouselCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *newsImage;
@property (nonatomic, strong) UILabel *newsTitle;
@property (nonatomic, strong) UIPageControl *carouselPageControl;

@property (nonatomic, strong) CFHomeStoryModel *topStoryModel;

@end
