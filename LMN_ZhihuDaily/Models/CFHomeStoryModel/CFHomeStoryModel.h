//
//  CFHomeStoryModel.h
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/19.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFHomeStoryModel : NSObject

/**
 * "stories": 
 {
 "images": [
 "http://pic2.zhimg.com/bb932e98de3bd1fbe4bf74a5e86c52cd.jpg"
 ],
 "type": 0,
 "id": 8788676,
 "ga_prefix": "091317",
 "title": "知乎好问题 · 国内有哪些冷门但有特色的旅游地点？"
 },
 */

/*"top_stories":
 {
 "image": "http://pic2.zhimg.com/34afc742188aaa7707a016ffc35cdc9d.jpg",
 "type": 0,
 "id": 8802910,
 "ga_prefix": "091817",
 "title": "知乎好问题 · 有哪些好吃又健康而且适合在家做的甜品？"
 },
 */

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *ga_prefix;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSURL *image;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)homeStoryWithDict:(NSDictionary *)dict;

@end
