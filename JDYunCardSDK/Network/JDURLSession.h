//
//  JDURLSession.h
//  JDYunCardSDK
//
//  Created by xiaoyi li on 16/9/22.
//  Copyright © 2016年 xiaoyi li. All rights reserved.
//

/**
 *  核心数据请求的接口类，供第三方客户调用
 *  这个类不包含任何第三方网络请求库
 *  用户可以放心使用，不会跟自己项目的第三方库冲突
 */

#import <Foundation/Foundation.h>
#import "JDAPI.h"
#import "JDCommonConstant.h"

// 云卡SDK初始化回调
typedef void(^JDYunCardSDKInitializationBlock)(NSDictionary *initializationDictionary);

// 云卡SDK绑定回调
typedef void(^JDYunCardSDKBindBlock)(NSDictionary *bindDictionary);

// 云卡产品列表回调
typedef void(^JDYunCardSDKProcutListBlock)(NSArray *products);



@interface JDURLSession : NSObject<NSURLSessionDelegate>

/**
 单例

 @return 返回网络请求单例
 */

+ (JDURLSession *)Manager;


#pragma mark - 云卡SDK绑定

/**
 云卡SDK绑定

 @param appid       云平台申请的应用ID
 @param terminal    云平台申请的终端号
 @param unique      云平台申请的终端号
 @param extendsInfo APP自定义信息
 */

- (void)bind:(NSString *)appid terminal:(NSString *)terminal unique:(NSString *)unique extendsInfo:(NSString *)extendsInfo bindBlock:(JDYunCardSDKBindBlock)bindBlock;



#pragma mark - 云卡SDK初始化
/**
 云卡SDK初始化

 @param initBlock 初始化的回调
 */
- (void)initialization:(JDYunCardSDKInitializationBlock)initBlock;


#pragma mark - 云卡产品列表
/**
 云卡产品列表

 @param listBlock 产品列表的回调
 */
- (void)getCardList:(JDYunCardSDKProcutListBlock)listBlock;



@end
