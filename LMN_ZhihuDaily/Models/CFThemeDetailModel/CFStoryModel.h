//
//  CFStoryModel.h
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/27.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFStoryModel : NSObject

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
*/

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSString *ID;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)storyWithDict:(NSDictionary *)dict;

@end
