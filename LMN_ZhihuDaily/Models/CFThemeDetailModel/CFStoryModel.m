//
//  CFStoryModel.m
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/27.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "CFStoryModel.h"

@implementation CFStoryModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if(self) {
        self.images = dict[@"images"];
        self.title = dict[@"title"];
        self.ID = dict[@"id"];
    }
    return self;
}
+ (instancetype)storyWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
