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
#import <CommonCrypto//CommonCrypto.h>

@implementation JDUtils

/**
 * 获取API的版本号
 */


+ (NSString *)JDYunSDKVerson {
    return JD_YUN_CARD_SDK_VER;
}

@end
