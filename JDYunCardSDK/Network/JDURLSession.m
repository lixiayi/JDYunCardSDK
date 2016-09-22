//
//  JDURLSession.m
//  JDYunCardSDK
//
//  Created by xiaoyi li on 16/9/22.
//  Copyright © 2016年 xiaoyi li. All rights reserved.
//

#import "JDURLSession.h"

typedef void(^NSURLSessionFinishBlock)(NSData *data,NSError *error);

NS_ASSUME_NONNULL_BEGIN
@interface JDURLSession()

/**
 正在执行的请求
 */
@property (nonatomic, strong) NSMutableURLRequest *request;

/**
 正在执行的session
 */
@property (nonatomic, strong) NSURLSession *mainSession;

/**
 接口地址
 */
@property (nonatomic, strong) NSURL *interfaceAddress;

@end

NS_ASSUME_NONNULL_END

@implementation JDURLSession


#pragma mark - 构建请求管理器
/**
 单例
 
 @return 返回网络请求单例
 */

+ (JDURLSession *)Manager {
    static JDURLSession *mangaer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mangaer = [[JDURLSession alloc] initRequest];
    });
    return mangaer;
}

#pragma mark - 初始化请求

/**
 初始化请求

 @return 返回请求实例
 */

- (id)initRequest {
    self = [super init];
    if (self) {
        self.interfaceAddress = [NSURL URLWithString:SERVER_URL];
        self.request = [[NSMutableURLRequest alloc] init];
        [self.request setHTTPMethod:@"POST"];
        [self.request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.request setTimeoutInterval:60];
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.mainSession = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        
    }
    return self;
}

#pragma mark - POST请求数据

/**
 核心方法：POST请求数据

 @param url         服务器地址
 @param str         提交的数据
 @param finishBlock 提交完成后的回调
 */

- (void)postRequestToServer:(NSURL *)url paramStr:(NSString *)str block:(NSURLSessionFinishBlock)finishBlock {
    self.request.URL = url;
    self.request.HTTPBody = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionDataTask *sessionDataTask = [self.mainSession dataTaskWithRequest:self.request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (finishBlock) {
            finishBlock(data,error);
        }
    }];
    
    [sessionDataTask resume];
}

#pragma mark - 取消请求
/**
 取消所有的请求
 */

- (void)cancelAllRequest {
    [self.mainSession invalidateAndCancel];
}

#pragma mark - 云卡SDK绑定

/**
 云卡SDK绑定
 
 @param appid       云平台申请的应用ID
 @param terminal    云平台申请的终端号
 @param unique      云平台申请的终端号
 @param extendsInfo APP自定义信息
 */

- (void)bind:(NSString *)appid terminal:(NSString *)terminal unique:(NSString *)unique extendsInfo:(NSString *)extendsInfo bindBlock:(JDYunCardSDKBindBlock)bindBlock{
    NSDictionary *applicationDicityorny = [NSDictionary dictionaryWithObjectsAndKeys:appid,@"appid",
                                           terminal,@"terminal",unique,@"unique",extendsInfo,@"extendsInfo", nil];
    
    NSMutableDictionary *signDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    NSString *postStr = [[JDAPI shareApi] getParamsWithAppParam:applicationDicityorny withSignParam:signDictionary];
    [[JDURLSession Manager] postRequestToServer:self.interfaceAddress paramStr:postStr block:^(NSData *data, NSError *error) {
        if (data) {
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            bindBlock(responseDictionary);
        } else {
            bindBlock(nil);
        }
    }];
}

#pragma mark - 云卡SDK初始化
/**
 云卡SDK初始化
 
 @param initBlock 初始化的回调
 */
- (void)initialization:(JDYunCardSDKInitializationBlock)initBlock {
    NSDictionary *applicationDicityorny = [NSDictionary dictionary];
    NSMutableDictionary *signDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    NSString *postStr = [[JDAPI shareApi] getParamsWithAppParam:applicationDicityorny withSignParam:signDictionary];
    [[JDURLSession Manager] postRequestToServer:self.interfaceAddress paramStr:postStr block:^(NSData *data, NSError *error) {
        if (data) {
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            initBlock(responseDictionary);
        } else {
            initBlock(nil);
        }
    }];
}

#pragma mark - 云卡产品列表
/**
 云卡产品列表
 
 @param listBlock 产品列表的回调
 */
- (void)getCardList:(JDYunCardSDKProcutListBlock)listBlock {
    
}
@end
