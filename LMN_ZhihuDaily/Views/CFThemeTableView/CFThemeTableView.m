//
//  CFThemeTableView.m
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/26.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "CFThemeTableView.h"

@interface CFThemeTableView () 
@end

@implementation CFThemeTableView

- (void)setDataDict:(NSMutableArray *)dataDict {
    _dataDict = dataDict;
}

- (void)setAuthorArr:(NSMutableArray *)authorArr {
    _authorArr = authorArr;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

@end
