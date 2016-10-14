//
//  CFSettingsSwitchItem.h
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/23.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "CFSettingsItem.h"

@interface CFSettingsSwitchItem : CFSettingsItem

+ (instancetype)switchItemWithTitle:(NSString *)title andSwitchStatus:(BOOL)status;

@end
