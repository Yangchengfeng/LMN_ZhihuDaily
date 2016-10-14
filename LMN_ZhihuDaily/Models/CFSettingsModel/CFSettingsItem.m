//
//  CFSettingsItem.m
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/23.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "CFSettingsItem.h"

@implementation CFSettingsItem

+ (instancetype)itemInitWithTitle:(NSString *)title {
    CFSettingsItem *item = [[self alloc] init];
    item.title = title;
    return item;
}

@end
