//
//  CFFootModel.m
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/10/3.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "CFFootModel.h"

@implementation CFFootModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if(self) {
        self.popularity = dict[@"popularity"];
        self.comments = dict[@"comments"];
    }
    return self;
}

+ (instancetype)footModelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}


@end
