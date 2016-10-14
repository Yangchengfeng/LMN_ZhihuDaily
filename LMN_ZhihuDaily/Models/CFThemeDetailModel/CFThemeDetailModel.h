//
//  CFThemeDetailModel.h
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/25.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFThemeDetailModel : NSObject
/*
"stories": [
            {
                "type": 0,
                "id": 8362682,
                "title": "更多互联网安全的内容，都在读读日报里"
            },
             {
             "images": [
             "http://pic3.zhimg.com/ca912fc8405360ada01a61f7c78e474a.jpg"
             ],
             "type": 0,
             "id": 7116244,
             "title": "我怕我做得不好，让你以为艺术不过如此"
            },],
"description": "把黑客知识科普到你的面前",
"background": "http://p4.zhimg.com/32/55/32557676e84fcfda4d82d9b8042464e1.jpg",
"color": 9699556,
"name": "互联网安全",
"image": "http://p4.zhimg.com/30/6f/306f3ab291c415f40fe4485b75627230.jpg",
"editors": [
            {
                "url": "http://www.zhihu.com/people/THANKS",
                "bio": "FreeBuf.com 小编，专注黑客与极客",
                "id": 65,
                "avatar": "http://pic4.zhimg.com/ecd93e213_m.jpg",
                "name": "THANKS"
            }],
"image_source": ""
*/

@property (nonatomic, strong) NSArray *stories;
@property (nonatomic, strong) NSURL *background;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSDictionary *editors;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)themeDetailWithDict:(NSDictionary *)dict;

@end
