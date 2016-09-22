//
//  JDAPI.m
//  MetroInterfaceDemo
//
//  Created by xiaoyi li on 16/8/25.
//  Copyright © 2016年 xiaoyi li. All rights reserved.
//

#import "JDAPI.h"
#import "URLCode.h"
#import "APIConstant.h"
#import "MD5.h"
#import "JDCommonConstant.h"
#import "JDUtils.h"


static JDAPI *jd_api = nil;

@implementation JDAPI

#pragma mark - 单例
+ (id)shareApi {
    dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        jd_api = [[self alloc] init];
    });
    return jd_api;
}

#pragma mark - 生成最后的URL字符串

/**
 生成最后的url字符串

 @param dic     应用级的参数字典
 @param signDic 签名后的字典

 @return 最终的url
 */
- (NSString *)getParamsWithAppParam:(NSDictionary *)dic
                       withSignParam:(NSMutableDictionary *)signDic{
    
    if (!dic) { return err_msg1;}
    
    if (!signDic) {return err_msg2;}
    
    NSString *ret_str = @"";
    // 获取应用级参数
    NSMutableDictionary *obj = [NSMutableDictionary dictionaryWithDictionary:dic];
    // 获取系统级参数
    [obj addEntriesFromDictionary:[self getSystemParams:self.api_name withToken:NO]];
    // 添加签名
    obj[@"sign"] = [self getSign:signDic];
    
    NSString *body = [self stringPairsFromDictionary:obj];
    ret_str = [NSString stringWithFormat:@"%@?%@", SERVER_URL, body];
    
    return ret_str;
}

#pragma mark- 生成数字签名(根据规则来定，如果是RSA则换成RSA签名)
/**
 生成数字签名(根据规则来定，如果是RSA则换成RSA签名)
 
 @param dic 待签名的字典
 
 @return 返回前面后的字符串
 */
- (NSString *) getSign:(NSMutableDictionary *)dic
{
    NSString *resStr = nil;
    @try {

        if (dic) {
            NSArray *allValues = dic.allValues;
            if (allValues.count > 1) {
                resStr = [allValues componentsJoinedByString:@""];
            } else if(allValues.count == 1){
                resStr = [allValues objectAtIndex:0];
            } else {
                return err_msg2;
            }
        } else {
            return err_msg2;
        }
        
        resStr = [MD5 MD5Digest:resStr];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", [exception description]);
    }
    
    if ([resStr length] < 1) {
        resStr = @"";
    }
    
    return resStr;
}


#pragma mark - 生成key=value
/**
 生成key=value

 @param dit 待生成的键值对

 @return 生成key=value链接后的字符串
 */
- (NSString *)stringPairsFromDictionary:(NSDictionary *)dit {
    if (!dit) {
        return err_msg1;
    }
    
    NSMutableArray *ret_arr = [NSMutableArray arrayWithCapacity:0];
    
    [dit enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"key = %@, obj = %@", key, obj);
        [ret_arr addObject:[self stringPairsFromKey:key andValue:obj]];
    }];
    
    NSString *ret_str = [ret_arr componentsJoinedByString:@"&"];
    return  ret_str;
}

- (NSString *)stringPairsFromKey:(NSString *)key andValue:(NSString *)value {
    if ([key length] < 1 || [value length] < 1) {
        return @"";
    } else {
        return [NSString stringWithFormat:@"%@=%@", [URLCode encode:key], [URLCode encode:value]];
    }
}

#pragma mark - 获得系统级参数
/**
 获取系统参数

 @param apiName api的名称
 @param token   token

 @return 返回系统参数的字典
 */
- (NSDictionary *)getSystemParams:(NSString *)apiName withToken:(BOOL)token{
    NSMutableDictionary *mut_dic = [NSMutableDictionary dictionary];
    [mut_dic setValue:apiName forKey:@"api_name"];
    [mut_dic setValue:ver forKey:@"ver"];
    [mut_dic setValue:formate forKey:@"format"];
    [mut_dic setValue:app_id forKey:@"app_id"];
    [mut_dic setValue:[JDUtils getCurrentTime] forKey:@"timestamp"];
    if (token) {
        [mut_dic setValue:s_token forKey:@"token"];
    }
    return mut_dic;
}

@end
