//
//  CFAboutViewController.m
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/24.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "CFAboutViewController.h"

@interface CFAboutViewController ()

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation CFAboutViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}

- (NSMutableArray *)dataArr {
    if(_dataArr == nil) {
        _dataArr = [NSMutableArray array];
        
        NSArray *arr = @[@"去评分", @"客服电话"];
        
        [_dataArr addObjectsFromArray:arr];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.showsVerticalScrollIndicator = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textLabel.text = [NSString stringWithFormat:@"%@", _dataArr[indexPath.row]];
    
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if([cell.textLabel.text isEqualToString:@"客服电话"]) {
            UILabel *phoneNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/5.0*3-30, 0, 140, 50)];
            phoneNumLabel.text = @"8613116727360";
            phoneNumLabel.font = [UIFont systemFontOfSize:15];
            phoneNumLabel.textColor = [UIColor lightGrayColor];
            phoneNumLabel.backgroundColor = [UIColor clearColor];
            [cell addSubview:phoneNumLabel];
        }
        
    }
    
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 300;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
    [imageView setImage:[UIImage imageNamed:@"Logo"]];
    imageView.center = CGPointMake(kScreenWidth/2.0, 280/2.0);
    [view addSubview:imageView];
    UILabel *versionlabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2.0-60, CGRectGetMaxY(imageView.frame) + 15, 120, 25)];
    versionlabel.font = [UIFont systemFontOfSize:14];
    versionlabel.textAlignment = NSTextAlignmentCenter;
    versionlabel.textColor = [UIColor lightGrayColor];
    NSString *versionText = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *buildVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    versionlabel.text = [NSString stringWithFormat:@"版本：%@ build %@", versionText, buildVersion];
    [view addSubview:versionlabel];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row == 2) {
        [self makeACall];
    } else {
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)makeACall{
    NSString *number = @"8613116727360";
    NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",number];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
}



@end
