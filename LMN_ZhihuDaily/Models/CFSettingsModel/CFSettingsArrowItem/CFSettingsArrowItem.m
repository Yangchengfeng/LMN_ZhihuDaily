//
//  CFSettingsArrowItem.m
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/23.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "CFSettingsArrowItem.h"

@implementation CFSettingsArrowItem

+ (instancetype)arrowItemWithTitle:(NSString *)title andDetinationVCClass:(Class)destinationVCClass {
    CFSettingsArrowItem *arrowItem = [[self alloc] init];
    arrowItem.title = title;
    arrowItem.destinationVCClass = destinationVCClass;
    return arrowItem;
}

@end
