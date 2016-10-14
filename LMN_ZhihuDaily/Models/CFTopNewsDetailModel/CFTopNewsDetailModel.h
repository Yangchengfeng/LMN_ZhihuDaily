//
//  CFTopNewsDetailModel.h
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/10/2.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFTopNewsDetailModel : NSObject

/*{
    "body": "",
    "image_source": "SansanL / 知乎",
    "title": "假期的早晨，做一杯 smoothie 唤醒自己",
    "image": "http://pic3.zhimg.com/7abcdd043c20b3b93a5b127f34c23e02.jpg",
    "share_url": "http://daily.zhihu.com/story/8845242",
    "js": [],
    "ga_prefix": "100207",
     recommenders": [
     { "avatar": "http://pic2.zhimg.com/fcb7039c1_m.jpg" },
     { "avatar": "http://pic1.zhimg.com/29191527c_m.jpg" },
     { "avatar": "http://pic4.zhimg.com/e6637a38d22475432c76e6c9e46336fb_m.jpg" },
     { "avatar": "http://pic1.zhimg.com/bd751e76463e94aa10c7ed2529738314_m.jpg" },
     { "avatar": "http://pic1.zhimg.com/4766e0648_m.jpg" }
     ], // 或者是(null)
     section": {
     "thumbnail": "http://pic4.zhimg.com/6a1ddebda9e8899811c4c169b92c35b3.jpg",
     "id": 1,
     "name": "深夜惊奇"
     },
    "images": [
               "http://pic4.zhimg.com/1af1db8625a52403dfef7b72419a79c3.jpg"
               ],
    "type": 0,
    "id": 8845242,
    "css": [
            "http://news-at.zhihu.com/css/news_qa.auto.css?v=4b3e3"
            ]
}*/



@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *image_source;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *storyID;
@property (nonatomic, strong) NSArray *recommenders;
@property (nonatomic, strong) NSArray *css;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)topNewsDetailModelWithDict:(NSDictionary *)dict;

@end
