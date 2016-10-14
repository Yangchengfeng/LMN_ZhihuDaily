//
//  CFEditorsCell.m
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/25.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "CFEditorsCell.h"

@implementation CFEditorsCell

- (instancetype)init {
    self = [super init];
    if(self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"CFEditorsCell" owner:nil options:nil].firstObject;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
