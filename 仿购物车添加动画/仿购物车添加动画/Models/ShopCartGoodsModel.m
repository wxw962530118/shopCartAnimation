//
//  ShopCartGoodsModel.m
//  仿购物车添加动画
//
//  Created by 王新伟 on 2017/6/24.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "ShopCartGoodsModel.h"

@implementation ShopCartGoodsModel
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"goodsID"             : @"id",
             @"goodsIcon"           : @"icon",
             @"goodsName"           : @"name",
             @"goodsOriginalPrice"  : @"originalPrice",
             @"goodsSalePrice"      : @"salePrice",
             @"goodsStock"          : @"stock",
             @"goodsDesc"           : @"desc",
             @"orderCount"          : @"orderCount"
             };
}
@end
