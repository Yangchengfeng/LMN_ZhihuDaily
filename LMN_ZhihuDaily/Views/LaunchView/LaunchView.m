//
//  LaunchView.m
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/10.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "LaunchView.h"

@implementation LaunchView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor clearColor];

    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"AD_Icon"];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(self.mas_width).multipliedBy(0.14);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(20);
    }];
    
    UILabel *upLabel = [[UILabel alloc] init];
    upLabel.text = @"玫日一报";
    upLabel.textColor = [UIColor whiteColor];
    upLabel.font = [UIFont systemFontOfSize:16];
    upLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:upLabel];
    [upLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).offset(20);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(18.0);
        make.centerY.equalTo(self.mas_centerY).offset(-18.0/2.0);
    }];
    
    UILabel *downLabel = [[UILabel alloc] init];
    downLabel.text = @"每日三次，每次七分钟";
    downLabel.textColor = kColorRGBA(150, 150, 150, 1);
    downLabel.font = [UIFont systemFontOfSize:12];
    downLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:downLabel];
    [downLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).offset(20);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(18.0);
        make.centerY.equalTo(self.mas_centerY).offset(18.0/2.0);
    }];
    
    return self;
}
@end
