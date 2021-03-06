//
//  ShopCartGoodsCategoryModel.h
//  仿购物车添加动画
//
//  Created by 王新伟 on 2017/6/24.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import <Foundation/Foundation.h>
//商品分类模型
@interface ShopCartGoodsCategoryModel : NSObject
/** 商品分类名称 */
@property (nonatomic,copy) NSString * goodsCategoryName;
/** 商品分类说明 */
@property (nonatomic,copy) NSString * goodsCategoryDesc;
/** 商品分类中包含的商品模型数组 */
@property (strong, nonatomic) NSMutableArray <ShopCartGoodsModel*>* goodsArray;
@end
