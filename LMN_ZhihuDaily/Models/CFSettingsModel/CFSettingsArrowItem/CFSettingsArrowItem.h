//
//  CFSettingsArrowItem.h
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/23.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "CFSettingsItem.h"

@interface CFSettingsArrowItem : CFSettingsItem

@property (nonatomic, assign) Class destinationVCClass; // 跳转到的控制器的类

+ (instancetype)arrowItemWithTitle:(NSString *)title andDetinationVCClass:(Class)destinationVCClass;

@end
