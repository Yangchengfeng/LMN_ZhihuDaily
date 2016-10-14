//
//  CFSettingsConfigItem.m
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/23.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "CFSettingsConfigItem.h"

@implementation CFSettingsConfigItem

+ (instancetype)itemInitWithIcon:(NSString *)icon title:(NSString *)title andDestinationVCClass:(Class)destinationVCClass {
    CFSettingsConfigItem *configItem = [[self alloc] init];
    configItem.icon = icon;
    configItem.title = title;
    configItem.destinationVCClass = destinationVCClass;
    return configItem;
}

@end
