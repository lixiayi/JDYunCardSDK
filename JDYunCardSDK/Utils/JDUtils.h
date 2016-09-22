//
//  JDUtils.h
//  JDYunCardSDK
//
//  Created by xiaoyi li on 16/9/21.
//  Copyright © 2016年 xiaoyi li. All rights reserved.
//

/**
 * 基础工具类
 */

#import <Foundation/Foundation.h>

@interface JDUtils : NSObject

/**
 * 获取API的版本号
 */

+ (NSString *)JDYunSDKVerson;

/**
 * 获取当前时间
 * 格式:yyyy-MM-dd HH:mm:ss
 */
+ (NSString *)getCurrentTime;

@end
