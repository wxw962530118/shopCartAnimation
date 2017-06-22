//
//  GoodsCategory.m
//  仿购物车添加动画
//
//  Created by 王新伟 on 2017/6/21.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "GoodsCategory.h"

@implementation GoodsCategory

+ (NSDictionary *)objectClassInArray {
    return @{
             @"goodsArray" : [GoodsModel class],
             };
}
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"goodsCategoryName" : @"name",
             @"goodsCategoryDesc" : @"desciption",
             @"goodsArray"        : @"goods"
             };
}
@end
