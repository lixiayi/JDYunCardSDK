//
//  JDAPI.h
//  MetroInterfaceDemo
//
//  Created by xiaoyi li on 16/8/25.
//  Copyright © 2016年 xiaoyi li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDAPI : NSObject

@property (nonatomic, strong)   NSString *api_name;
@property (nonatomic, strong)   NSString *api_url;

/**
 *  单例构造器
 *
 *  @return 返回单例
 */

+ (id)shareApi;

/**
 *  获取请求的参数拼接成的URL字符串
 *  @param dic       应用级别参数
 *  @param signDic   参与签名的字典
 *
 *  @return 请求的url字符串
 */

- (NSString *)getParamsWithAppParam:(NSDictionary *)dic
                       withSignParam:(NSMutableDictionary *)signDic;

@end
