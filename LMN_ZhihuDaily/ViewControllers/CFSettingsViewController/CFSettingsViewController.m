//
//  CFSettingsViewController.m
//  CFDemo
//
//  Created by 阳丞枫 on 16/9/23.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "CFSettingsViewController.h"
#import "MainViewController.h"
// 四种item
#import "CFSettingsItem.h"
#import "CFSettingsSwitchItem.h"
#import "CFSettingsConfigItem.h"
#import "CFSettingsArrowItem.h"
// 一个group
#import "CFSettingsGroup.h"
// 一个cell
#import "CFSettingsCell.h"
// 跳转到某个控制器
#import "CFLoginViewController.h"
#import "CFLogoutViewController.h"
#import "CFAboutViewController.h"

@interface CFSettingsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr; // 数据种类

@end

@implementation CFSettingsViewController

- (NSMutableArray *)dataArr {
    if(!_dataArr) {
        _dataArr = [NSMutableArray array];
    
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        CFSettingsConfigItem *configItem;
        if([userDefault objectForKey:@"uid"]) {
            configItem = [CFSettingsConfigItem itemInitWithIcon:@"Light_Account_Avatar" title:@"我的资料" andDestinationVCClass:[CFLogoutViewController class]];
            
        } else {
            configItem = [CFSettingsConfigItem itemInitWithIcon:@"Light_Account_Avatar" title:@"我的资料" andDestinationVCClass:[CFLoginViewController class]];
        
        }
        CFSettingsGroup *group0 = [[CFSettingsGroup alloc] init];
        group0.groupItems = @[configItem];
        [_dataArr addObject:group0];
        
        CFSettingsSwitchItem *switchItem = [CFSettingsSwitchItem switchItemWithTitle:@"自动离线下载" andSwitchStatus:YES];
        CFSettingsGroup *group1 = [[CFSettingsGroup alloc] init];
        group1.groupItems = @[switchItem];
        [_dataArr addObject:group1];
        
        CFSettingsSwitchItem *switchItem0 = [CFSettingsSwitchItem switchItemWithTitle:@"移动网络不下载图片" andSwitchStatus:NO];
        CFSettingsSwitchItem *switchItem1 = [CFSettingsSwitchItem switchItemWithTitle:@"消息推送" andSwitchStatus:YES];
        CFSettingsGroup *group2 = [[CFSettingsGroup alloc] init];
        group2.groupItems = @[switchItem0, switchItem1];
        [_dataArr addObject:group2];

        CFSettingsArrowItem *arrowItem = [CFSettingsArrowItem  arrowItemWithTitle:@"字体大小" andDetinationVCClass:[UIViewController class]];
        CFSettingsArrowItem *arrowItem0 = [CFSettingsArrowItem arrowItemWithTitle:@"关于玫日一报" andDetinationVCClass:[CFAboutViewController class]];
        CFSettingsGroup *group3 = [[CFSettingsGroup alloc] init];
        group3.groupItems = @[arrowItem, arrowItem0];
        [_dataArr addObject:group3];
        
        CFSettingsItem *baseItem = [CFSettingsItem itemInitWithTitle:@"清除缓存"];
        CFSettingsGroup *group5 = [[CFSettingsGroup alloc] init];
        group5.groupItems = @[baseItem];
        [_dataArr addObject:group5];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"设置";
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 35)];
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [btn setImage:[UIImage imageNamed:@"Back_white"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"Back_white"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationController.navigationBar.barTintColor = kColorRGBA(52, 185, 252, 1.0); // 更改导航栏颜色
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}

- (void)back {
    MainViewController *mainVC = [[MainViewController alloc] init];
    self.view.window.rootViewController = mainVC;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CFSettingsGroup *group = self.dataArr[section];
    NSArray *itemArr = group.groupItems;
    return itemArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CFSettingsCell *cell = [CFSettingsCell cellWithTableView:tableView];
    
    CFSettingsGroup *group = self.dataArr[indexPath.section];
    CFSettingsItem *item = group.groupItems[indexPath.row];
    
    cell.settingsItem = item;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 20;
    }
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if(section == 1) {
        return 20;
    }
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if(section == 1) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth, 20)];
        label.text = @"     仅wi-fi下可用，自动下载最新内容";
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:11];
        return label;
    } else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CFSettingsGroup *group = self.dataArr[indexPath.section];
    CFSettingsItem *item = group.groupItems[indexPath.row];
    
    if([item isKindOfClass:[CFSettingsArrowItem class]] || [item isKindOfClass:[CFSettingsConfigItem class]]) {
        CFSettingsArrowItem *arrowItem = (CFSettingsArrowItem *)item;
        if(arrowItem.destinationVCClass) {
            UIViewController *vc = [[arrowItem.destinationVCClass alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            vc.title = item.title;
        }
    } else if([item isKindOfClass:[CFSettingsSwitchItem class]]) {
    } else {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"清除缓存中..."
                                                                       message:nil
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

#pragma mark - 设置最顶部为白色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
