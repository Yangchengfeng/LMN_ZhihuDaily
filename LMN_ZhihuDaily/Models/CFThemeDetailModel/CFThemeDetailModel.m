//
//  CFThemeDetailModel.m
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/25.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "CFThemeDetailModel.h"

@implementation CFThemeDetailModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if(self) {
        self.stories = dict[@"stories"];
        self.background = dict[@"background"];
        self.name = dict[@"name"];
        self.editors = dict[@"editors"];
        
    }
    return self;
}
+ (instancetype)themeDetailWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
