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
     "https://pic4.zhimg.com/v2-48ee364f2e2d28909c9047d0a876b0fb.jpg"
     ],
     "type": 0,
     "id": 9393224,
     "ga_prefix": "050122",
     "title": "小事 · 旅途愉快"
     },
     {
     "title": "为什么陈凯歌再没拍出这样好的电影来？",
     "ga_prefix": "050121",
     "images": [
     "https://pic3.zhimg.com/v2-9cbb836d62367b202637c4e9320fc14a.jpg"
     ],
     "multipic": true,
     "type": 0,
     "id": 9393089
    },
 */

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *ga_prefix;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSURL *image;
@property (nonatomic, assign) BOOL multipic;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)homeStoryWithDict:(NSDictionary *)dict;

@end
