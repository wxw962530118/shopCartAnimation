//
//  GoodsModel.h
//  仿购物车添加动画
//
//  Created by 王新伟 on 2017/6/21.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import <Foundation/Foundation.h>
//商品模型
@interface GoodsModel : NSObject
/** 商品编号 */
@property (nonatomic,copy) NSString * goodsID;
/** 商品图标 */
@property (nonatomic,copy) NSString * goodsIcon;
/** 商品名称 */
@property (nonatomic,copy) NSString * goodsName;
/** 商品定价（原价） */
@property (nonatomic,assign) double goodsOriginalPrice;
/** 商品售价 */
@property (nonatomic,assign) double goodsSalePrice;
/** 商品库存数量 */
@property (nonatomic,assign) int goodsStock;
/** 商品订单数量 */
@property (nonatomic,assign) int orderCount;
/** 商品简介 */
@property (nonatomic,copy) NSString * goodsDesc;
@end
