//
//  CFSettingsCell.h
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/24.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CFSettingsItem; // 添加一个模型

@interface CFSettingsCell : UITableViewCell

@property (nonatomic, strong) CFSettingsItem *settingsItem;
+ (CFSettingsCell *)cellWithTableView:(UITableView *)tableView;

@end
