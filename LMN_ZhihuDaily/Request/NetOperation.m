//
//  NetOperation.m
//  LMN_ZhihuDaily
//
//  Created by 阳丞枫 on 16/9/9.
//  Copyright © 2016年 chengfengYang. All rights reserved.
//

#import "NetOperation.h"

@implementation NetOperation

+ (void)getRequestWithURL:(NSString *)urlStr parameter:(id)param success:(success)success andfailure:(failure)failure {
    
    AFHTTPSessionManager *httpManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseURLStr]];
    // url用的都是GET方法
    [httpManager GET:urlStr parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if(success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(failure) {
            failure(error);
        }
    }];
}

@end
