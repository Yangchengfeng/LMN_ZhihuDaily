//
//  CFSettingsItem.h
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/23.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFSettingsItem : NSObject

@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL switchStatus; 

+ (instancetype)itemInitWithTitle:(NSString *)title;

@end
