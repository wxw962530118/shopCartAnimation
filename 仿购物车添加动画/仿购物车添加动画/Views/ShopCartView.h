//
//  ShopCartView.h
//  仿购物车添加动画
//
//  Created by 王新伟 on 2017/6/21.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
typedef void(^ShopCartViewBlock)(NSNumber * selectedCount);

@interface ShopCartView : UIView

/**
 构建订单页面

 @param shopCartSuperView 订单页面所在父视图
 @param goodsModelArray   订单模型数组
 @param callBack 点击行的回调
 */
+(instancetype)ShowShopCartViewWithShopCartSuperView:(UIView *)shopCartSuperView goodsModel:(NSMutableArray <GoodsModel *>*)goodsModelArray ShopCartViewBlock:(ShopCartViewBlock)callBack;

@end
