//
//  RootModel.m
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/29.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#import "RootModel.h"

@implementation RootModel

#pragma mark - JSON -> Model 转换示例
// 一、属性为数组，数组里是对象
//+ (NSDictionary *)modelContainerPropertyGenericClass
//{
//    return @{@"topicImageList" : [TopicImage class]};
//}

// 二、属性从新映射，下面是使用的时候的2个约定
// 1.统一使用数组
// 2.数组的第一个值必须是原属性名然后才是其他的字段
//+ (NSDictionary *)modelCustomPropertyMapper
//{
//    return @{
//             @"bookID" : @[@"bookID",@"id", @"ID", @"book_id"]
//             };
//}

/*  三、手动转换某个属性
 * `字典里值`与`模型的值`类型不一样`需要转换`而重写的方法
 *  NSDate *time     dic[@"t"]是double类型的的秒数
 */
//- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
//
//    self.time = (NSDate *)[NSDate dateWithTimeIntervalSince1970:[dic[@"t"] doubleValue]/1000];
//
//    return YES;
//}

#pragma mark -
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        [self modelInitWithCoder:aDecoder];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self modelEncodeWithCoder:aCoder];
}
- (id)copyWithZone:(NSZone *)zone
{
    return [self modelCopy];
}
- (NSUInteger)hash
{
    return [self modelHash];
}
- (BOOL)isEqual:(id)object
{
    return [self modelIsEqual:object];
}
- (NSString *)description
{
    NSString *desc = [NSString stringWithFormat:@"%@\n%@",[super description],self.modelToJSONObject];
    return desc;
}

@end
