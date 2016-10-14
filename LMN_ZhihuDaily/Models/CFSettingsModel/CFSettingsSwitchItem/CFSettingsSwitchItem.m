//
//  CFSettingsSwitchItem.m
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/23.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "CFSettingsSwitchItem.h"

@implementation CFSettingsSwitchItem

+ (instancetype)switchItemWithTitle:(NSString *)title andSwitchStatus:(BOOL)status {
    CFSettingsSwitchItem *switchItem = [self itemInitWithTitle:title];
    switchItem.switchStatus = status;
    return switchItem;
}

@end
