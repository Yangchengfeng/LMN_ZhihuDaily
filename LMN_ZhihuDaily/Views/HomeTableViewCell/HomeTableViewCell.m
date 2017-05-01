//
//  HomeTableViewCell.m
//  HomeViewController
//
//  Created by 阳丞枫 on 16/9/13.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "HomeTableViewCell.h"

@interface HomeTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *multiPicBtn;

@end

@implementation HomeTableViewCell

- (instancetype)init {
    self = [super init];
    if(self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"HomeTableViewCell" owner:nil options:nil].firstObject;
    }
    return self;
}

- (void)setStoryModel:(CFHomeStoryModel *)storyModel {
    if(storyModel == nil || [storyModel isEqual:@""]) {
        _title.text = @" ";
        [_images setImage:[UIImage imageNamed:@"Management_Placeholder"]];
    } else {
        _title.text = storyModel.title;
        if(!storyModel.multipic) {
            self.multiPicBtn.hidden = YES;
        }
        [[SDWebImageManager sharedManager] downloadImageWithURL:storyModel.images[0] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            // 下载进度block
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            // 下载完成block
            [_images setImage:[UIImage imageWithData:UIImageJPEGRepresentation(image, 0.8)]];
        }];
    }
}

- (void)setMenuStoryModel:(CFStoryModel *)menuStoryModel {
    if(menuStoryModel == nil || [menuStoryModel isEqual:@""]) {
        _title.text = @" ";
        [_images setImage:[UIImage imageNamed:@"Management_Placeholder"]];
    } else {
        _title.text = menuStoryModel.title;
        [[SDWebImageManager sharedManager] downloadImageWithURL:menuStoryModel.images[0] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            // 下载进度block
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            // 下载完成block
            [_images setImage:[UIImage imageWithData:UIImageJPEGRepresentation(image, 0.8)]];
        }];
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
