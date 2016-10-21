//
//  CFTopNewsViewController.h
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/10/1.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFTopNewsViewController : UIViewController

- (void)loadTopNewsWithID:(NSString *)ID;
- (void)loadSlideStoryWithID:(NSString *)ID;

@end
