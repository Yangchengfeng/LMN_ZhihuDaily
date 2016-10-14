//
//  CFSettingsGroup.h
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/24.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

/**
 *  每个section格式
 */
#import <Foundation/Foundation.h>

@interface CFSettingsGroup : NSObject

@property (nonatomic, strong) NSArray *groupItems;
// 这里不添加header和footer

@end
