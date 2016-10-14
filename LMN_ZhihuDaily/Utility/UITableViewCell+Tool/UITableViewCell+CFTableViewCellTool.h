//
//  UITableViewCell+CFTableViewCellTool.h
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/19.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//
/*
 这个方法仅是为了UITabelViewCell数据转模型时用
 */

#import <UIKit/UIKit.h>
#import "CFHomeStoryModel.h"
#import "CFStoryModel.h"
@class CFNewNoPicCell;

@interface UITableViewCell (CFTableViewCellTool)

@property (nonatomic, strong) CFHomeStoryModel *storyModel;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) CFStoryModel *menuStoryModel;

@end
