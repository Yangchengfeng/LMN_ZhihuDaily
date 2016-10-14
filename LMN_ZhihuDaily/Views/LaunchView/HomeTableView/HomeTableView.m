//
//  HomeTableView.m
//  HomeViewController
//
//  Created by 阳丞枫 on 16/9/13.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "HomeTableView.h"
#import "HomeTableViewCell.h"
#import "CarouselCollectionViewCell.h"
#import "UITableViewCell+CFTableViewCellTool.h"
#import "HomePageViewController.h"
#import "MainViewController.h"
#import "UINavigationBar+CFNavigationBarTool.h"
#import "CFTopNewsViewController.h"

// 定义一个宏作为cell的重用池
#define kTableViewCellReuse @"tableViewCellReuse"
#define kCollectionCellReuse @"colletionCellReuse"

@interface HomeTableView () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, retain) NSMutableArray *marr;// 存图片的数组
@property (nonatomic, strong) NSMutableArray *topStoriesTitleArr; // 标题数组
@property (nonatomic, strong) NSMutableArray *topStoriesImageArr; // 图片数组

@end

@implementation HomeTableView

#pragma  mark - set方法，前两个可以被后两个替代
-(void)setTopStoryArr:(NSMutableArray *)topStoryArr {
    _topStoryArr = topStoryArr;
}

- (void)setStoryArr:(NSMutableArray *)storyArr {
    _storyArr = storyArr;
}

#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if(self) {
        
        _topStoryArr = [NSMutableArray arrayWithObject:@""]; // 避免初始化“每个section的item个数”崩了
        
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        //2.初始化collectionView
        _carouselView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * 5, kHomeTableViewRowHeight) collectionViewLayout:layout];
        
        _carouselView.backgroundColor = [UIColor whiteColor];
        _carouselView.pagingEnabled = YES;//开启翻页效果
        _carouselView.delegate = self;
        _carouselView.dataSource = self;
        _carouselView.showsHorizontalScrollIndicator = NO;//滑条不出现
        
        //3.注册collectionViewCell
        //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
        [_carouselView registerClass:[CarouselCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
        
        //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
        [_carouselView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
        
        //4.设置代理
        _carouselView.delegate = self;
        _carouselView.dataSource = self;
        
        //设置起始位置
        [_carouselView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        self.tableHeaderView = _carouselView;
        
        [self createPhone];
        [self addTimer];
    }
    return self;
}

#pragma mark - collectionView的代理方法

//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.topStoryArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CarouselCollectionViewCell *cell = (CarouselCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.carouselPageControl.numberOfPages = self.topStoryArr.count;
    [cell.carouselPageControl setCurrentPage:indexPath.item];
    cell.topStoryModel = self.topStoryArr[indexPath.item];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, kHomeTableViewRowHeight);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self goToNewsDetailWithStoryModel:_topStoryArr[indexPath.item]];
}

- (void)createPhone {
    self.marr = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        NSString *name = [NSString stringWithFormat:@"Management_Placeholder"];
        UIImage *image = [UIImage imageNamed:name];
        [self.marr addObject:image];
    }
}

- (void)nextImage {
    //设置当前 indePath
    NSIndexPath *currrentIndexPath = [[_carouselView indexPathsForVisibleItems] lastObject];
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currrentIndexPath.item inSection:0];
    [_carouselView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    // 设置下一个滚动的item
    NSInteger nextItem = currentIndexPathReset.item +1;
    if (nextItem==self.marr.count) {
        nextItem=0;
        [_carouselView setContentOffset:CGPointMake(0, 0)];
        return; // 自动回到第一个
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:0];
    NSLog(@"%@", nextIndexPath);
    [_carouselView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (void)removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [self addTimer];
}

- (void)addTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

#pragma mark - tableView的代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.storyArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellReuse];
    if(cell == nil) {
        cell = [[HomeTableViewCell alloc] init];
        cell.storyModel = self.storyArr[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self goToNewsDetailWithStoryModel:_storyArr[indexPath.row]];
}

#pragma mark - 跳转到信息详情
- (void)goToNewsDetailWithStoryModel:(CFHomeStoryModel *)storyModel {
    CFTopNewsViewController *vc = [[CFTopNewsViewController alloc] init];
    NSString *topNewsID = storyModel.ID;
    [vc loadTopNewsWithID:topNewsID];
    vc.view.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = vc;
}

@end
