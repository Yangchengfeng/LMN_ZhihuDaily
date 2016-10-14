//
//  CFTopNewsDetailModel.m
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/10/2.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "CFTopNewsDetailModel.h"

@implementation CFTopNewsDetailModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if(self) {
        self.body = dict[@"body"];
        self.image_source = dict[@"image_source"];
        self.title = dict[@"title"];
        self.image = dict[@"image"];
        self.storyID = dict[@"id"];
        self.recommenders = dict[@"recommenders"];
        self.css = dict[@"css"];
        
    }
    return self;
}

+ (instancetype)topNewsDetailModelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
