//
//  ShopCartOrderView.h
//  仿购物车添加动画
//
//  Created by 王新伟 on 2017/6/24.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShopCartViewBlock)(NSNumber * selectedCount , BOOL isHideView, BOOL isClickAddBtn , NSMutableArray * array);

@interface ShopCartOrderView : UIView
/**
 构建订单页面
 
 @param shopCartSuperView 订单页面所在父视图
 @param goodsModelArray   订单模型数组
 @param callBack 点击行的回调
 */
+(instancetype)showShopCartOrderViewWithShopCartSuperView:(UIView *)shopCartSuperView goodsModel:(NSMutableArray <ShopCartGoodsModel *>*)goodsModelArray ShopCartViewBlock:(ShopCartViewBlock)callBack;

@end
