//
//  CFFootModel.h
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/10/3.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFFootModel : NSObject

/*
 {
 "long_comments": 0,
 "popularity": 12,
 "short_comments": 0,
 "comments": 0
 }
 */

@property (nonatomic, strong) NSString *popularity; // 点赞数
@property (nonatomic, strong) NSString *comments; // 评论数（长短评论）

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)footModelWithDict:(NSDictionary *)dict;

@end
