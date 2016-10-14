//
//  HomeTableViewCell.h
//  HomeViewController
//
//  Created by 阳丞枫 on 16/9/13.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFHomeStoryModel.h"
#import "CFStoryModel.h"

@interface HomeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *images;
@property (weak, nonatomic) IBOutlet UITextView *title;

@end
