//
//  CFShareCell.m
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/10/7.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "CFShareCell.h"

@implementation CFShareCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        _btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
        [_btn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btn];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.width+3, frame.size.width, frame.size.height-frame.size.width-3)];
        _label.textColor = [UIColor lightGrayColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:10];
        [self addSubview:_label];
    }
    return self;
}

- (void)share:(UIButton *)btn {
    NSLog(@"%d", btn.tag);
}

@end
