//
//  ShopCartBottomView.h
//  仿购物车添加动画
//
//  Created by 王新伟 on 2017/6/21.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCartBottomView : UIView

/**
 构建底部的工具条

 @param frame Frame
 @param shopCartSuperView 当前view所在父视图
 */
-(instancetype)initWithFrame:(CGRect)frame shopCartSuperView:(UIView *)shopCartSuperView;

@end
