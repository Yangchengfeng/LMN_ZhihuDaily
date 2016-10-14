//
//  CFNewNoPicCell.m
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/25.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "CFNewNoPicCell.h"
#import "UITableViewCell+CFTableViewCellTool.h"

@implementation CFNewNoPicCell

- (instancetype)init {
    self = [super init];
    if(self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"CFNewNoPicCell" owner:nil options:nil].firstObject;
    }
    return self;
}

- (void)setContent:(NSString *)content {
    _textView.text = content;
}

@end
