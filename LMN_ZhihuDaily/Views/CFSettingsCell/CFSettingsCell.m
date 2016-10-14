//
//  CFSettingsCell.m
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/24.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "CFSettingsCell.h"
// 三种item
#import "CFSettingsSwitchItem.h"
#import "CFSettingsConfigItem.h"
#import "CFSettingsArrowItem.h"
// 修改图片为圆形
#import "UIImage+CFImageTool.h"

@interface CFSettingsCell ()

@property (nonatomic, strong) UISwitch *switchView;

@end

@implementation CFSettingsCell

#pragma mark - 设置switch和箭头
- (UISwitch *)switchView {
    if(_switchView == nil){
        _switchView = [[UISwitch alloc] init];
        _switchView.on = _settingsItem.switchStatus;
        _switchView.onTintColor = kColorRGBA(52, 185, 252, 1.0);
    }
    return _switchView;
}

#pragma  mark - 设置单个item
- (void)setSettingsItem:(CFSettingsItem *)settingsItem {
    _settingsItem = settingsItem;
    [self setData];
    [self setAccessoryView];
}

// 设置文字和前置图片
- (void)setData {
    if([_settingsItem isKindOfClass:[CFSettingsConfigItem class]]) {
        UIImage *image = [UIImage compressImage:[UIImage imageNamed:_settingsItem.icon] toTargetWidth:35];
        [self.imageView setImage:[image circleImage]];
    }

    self.textLabel.text = _settingsItem.title;
    self.textLabel.font = [UIFont systemFontOfSize:15];
}

// 设置后置图片
- (void)setAccessoryView {
    if([_settingsItem isKindOfClass:[CFSettingsConfigItem class]] || [_settingsItem isKindOfClass:[CFSettingsArrowItem class]]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if([_settingsItem isKindOfClass:[CFSettingsSwitchItem class]]) {
        self.accessoryView = self.switchView;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
        self.accessoryView = nil;
    }
}


#pragma mark - 设置整个cell
+ (CFSettingsCell *)cellWithTableView:(UITableView *)tableView {
    static NSString *cellID = @"cellID";
    CFSettingsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil) {
        cell = [[CFSettingsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
