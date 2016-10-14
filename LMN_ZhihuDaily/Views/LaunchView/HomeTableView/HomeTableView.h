//
//  HomeTableView.h
//  HomeViewController
//
//  Created by 阳丞枫 on 16/9/13.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableView : UITableView

@property (nonatomic, strong) NSMutableArray *topStoryArr;
@property (nonatomic, strong) NSMutableArray *storyArr;
@property (nonatomic, strong) UICollectionView *carouselView;

@end
