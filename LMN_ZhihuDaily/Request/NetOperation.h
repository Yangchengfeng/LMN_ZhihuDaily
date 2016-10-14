//
//  NetOperation.h
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/9.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^success)(id responseObject);
typedef void(^failure)(NSError *error);

@interface NetOperation : NSObject

+ (void)getRequestWithURL:(NSString *)urlStr parameter:(id)param success:(success)success andfailure:(failure)failure;

@end
