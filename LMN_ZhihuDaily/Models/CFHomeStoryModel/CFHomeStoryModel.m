//
//  CFHomeStoryModel.m
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/19.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "CFHomeStoryModel.h"

@implementation CFHomeStoryModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if(self) {
        self.images = dict[@"images"];
        self.ID = dict[@"id"];
        self.ga_prefix = dict[@"ga_prefix"];
        self.title = dict[@"title"];
        self.image = dict[@"image"];
        self.multipic = dict[@"multipic"];
    }
    return self;
}

+ (instancetype)homeStoryWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
}

@end
