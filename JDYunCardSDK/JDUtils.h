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


#pragma mark - 加解密

/**
 * 哈希-1加密
 */

+ (NSString *)sha1:(NSString *)input;

/**
 * 哈希-256加密
 */

+ (NSString *)sha256:(NSString *)input;

/**
 * MD5加密
 */

+ (NSString *)MD5:(NSString *)input stringEncoding:(NSStringEncoding)encode;



@end
