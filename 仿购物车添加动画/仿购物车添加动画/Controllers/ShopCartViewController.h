//
//  ShopCartViewController.h
//  仿购物车添加动画
//
//  Created by 王新伟 on 2017/6/24.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCartViewController : UIViewController
/**订单数据 实际项目中需要从其他页面传入*/
@property (nonatomic, strong) NSMutableArray<ShopCartGoodsModel *> * orderArray;
@end
