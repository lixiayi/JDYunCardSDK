//
//  JDAPI.h
//  MetroInterfaceDemo
//
//  Created by xiaoyi li on 16/8/25.
//  Copyright © 2016年 xiaoyi li. All rights reserved.
//

/**
 使用方法：

 1、设置api_name
 2、调用 + (id)shareAPI方法创建管理器
 3、调用方通过字典的方式列出应用级的参数
 4、调用方通过字典的方式列出系统级别的参数
 5、调用 - (NSString *)getParamsWithAppParam:(NSDictionary *)dic 
    withSignParam:(NSMutableDictionary *)signDic生成最后的请求字符串
 */

#import <Foundation/Foundation.h>

@interface JDAPI : NSObject

@property (nonatomic, strong)   NSString *api_name;

/**
 *  单例构造器
 *
 *  @return 返回单例
 */

+ (id)shareAPI;

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
