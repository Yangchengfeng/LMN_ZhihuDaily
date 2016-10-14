//
//  UIImage+CFImageTool.h
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/21.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CFImageTool)

+ (instancetype)imageWithResizableImageName:(NSString *)imageName;

/**
 *  将获取到的图片修改为targetWidth，并按照比例修改高度
 */
+ (instancetype)compressImage:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth;

/**
 * 返回一张圆形图片
 */
- (instancetype)circleImage;

/**
 * 返回一张圆形图片
 */
+ (instancetype)circleImageNamed:(NSString *)name;


@end
