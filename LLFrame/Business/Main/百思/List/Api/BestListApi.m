//
//  BestListApi.m
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/31.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#import "BestListApi.h"

static NSString * APPID = @"53281";
static NSString * SECRET = @"21bb724a90ea43bc9fb78b92e6ef1778";

@interface BestListApi ()
{
    ListType _type;
    NSInteger _currentPage;
}

@end

@implementation BestListApi

- (instancetype)initWithType:(ListType)type currentPage:(NSInteger)currentPage
{
    self = [super init];
    if (self)
    {
        _type = type;
        _currentPage = currentPage;
    }
    return self;
}

- (NSString *)baseUrl
{
    return @"http://route.showapi.com/";
}

- (NSString *)requestUrl
{
    return @"255-1";
}

- (id)requestArgument
{
    NSMutableDictionary *argument = [NSMutableDictionary new];
    
    /*系统级参数*/
    {
        // 1.易源应用id
        NSString *showapi_appid = APPID;
        [argument setObject:showapi_appid forKey:@"showapi_appid"];
        
        // 2.客户端时间。
        // 格式yyyyMMddHHmmss,如20141114142239
        // 为了在一定程度上防止“重放攻击”，平台只接受在10分钟之内的请求。如果不传或传空串，则系统不再做此字段的检测。
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString *showapi_timestamp = [formatter stringFromDate:date];
        [argument setObject:showapi_timestamp forKey:@"showapi_timestamp"];
        
        // 3.签名生成方式，其值可选为"md5"或"hmac"。如果不传入则默认"md5"。
        NSString *showapi_sign_method = @"md5";
        [argument setObject:showapi_sign_method forKey:@"showapi_sign_method"];
        
        // 4.返回值是否用gzip方式压缩。此值为1时将压缩，其他值不压缩。
        NSString *showapi_res_gzip = @"0";
        [argument setObject:showapi_res_gzip forKey:@"showapi_res_gzip"];
    }
    
    /*应用级参数*/
    {
        // 查询的类型，默认全部返回。
        id type = _type > 0 ? @(_type) : @"";
        [argument setObject:type forKey:@"type"];
        
        // 文本中包括的内容，模糊查询
        NSString *title = @"";
        [argument setObject:title forKey:@"title"];
        
        // 第几页。每页最多返回20条记录
        NSNumber *page = @(_currentPage);
        [argument setObject:page forKey:@"page"];
    }
    
    // 签名
    {
        // 1 参与签名的key
        NSArray *keysArray = _type > 0 ? @[@"showapi_appid",@"showapi_timestamp",@"showapi_sign_method",@"showapi_res_gzip",@"type",@"page"] : @[@"showapi_appid",@"showapi_timestamp",@"showapi_sign_method",@"showapi_res_gzip",@"page"];
        
        // 2 对key进行字母序排序
        NSMutableArray *sortedKeyArray = [NSMutableArray arrayWithArray:keysArray];
        [sortedKeyArray sortUsingComparator:^NSComparisonResult(NSString* key1, NSString* key2) {
            return [key1 compare:key2];
        }];
        
        // 3 排序后以key+value方式拼装
        NSMutableString *sortedKeyValues = [NSMutableString new];
        [sortedKeyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSString *key = obj;
            NSString *keyValue = [NSString stringWithFormat:@"%@%@",key,argument[key]];
            [sortedKeyValues appendString:keyValue];
        }];
        
        // 4 MD5数字签名
        NSString *showapi_sign = [[NSString stringWithFormat:@"%@%@",sortedKeyValues,SECRET] md5String];
        [argument setObject:showapi_sign forKey:@"showapi_sign"];
    }
    
    return argument.copy;
}

@end
