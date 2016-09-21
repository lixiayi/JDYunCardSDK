//
//  JDUtils.m
//  JDYunCardSDK
//
//  Created by xiaoyi li on 16/9/21.
//  Copyright © 2016年 xiaoyi li. All rights reserved.
//

#import "JDUtils.h"
#import "JDCommonConstant.h"
#import <CommonCrypto/CommonDigest.h>

@implementation JDUtils

/**
 * 获取API的版本号
 */


+ (NSString *)JDYunSDKVerson {
    return JD_YUN_CARD_SDK_VER;
}

/**
 * 哈希-1加密
 */

+ (NSString *)sha1:(NSString *)input {
    const char *cStr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cStr length:[input length]];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)[data length], digest);
    
    NSMutableString *output = [[NSMutableString alloc] initWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (NSInteger i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",digest[i]];
    }
    
    return output;
}

/**
 * 哈希256加密
 */

+ (NSString *)sha256:(NSString *)input {
    const char *cStr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cStr length:[input length]];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(data.bytes, (CC_LONG)[data length], digest);
    
    NSMutableString *output = [[NSMutableString alloc] initWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    for (NSInteger i=0; i<CC_SHA256_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",digest[i]];
    }
    
    return output;
}

/**
 * MD5加密
 */

+ (NSString *)MD5:(NSString *)input stringEncoding:(NSStringEncoding)encode{
    const char *cStr = [input cStringUsingEncoding:encode];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *output = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH
    * 2];
    for (int i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",digest[i]];
    }
    
    return output;
}

@end
