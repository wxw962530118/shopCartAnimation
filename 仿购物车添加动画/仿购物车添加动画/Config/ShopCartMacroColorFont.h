//
//  ShopCartMacroColorFont.h
//  仿购物车添加动画
//
//  Created by 王新伟 on 2017/6/24.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#ifndef ShopCartMacroColorFont_h
#define ShopCartMacroColorFont_h

#define  ScreenWidth  [UIScreen mainScreen].bounds.size.width

#define  ScreenHeight [UIScreen mainScreen].bounds.size.height

#define  kTCCellIdentifier NSStringFromClass(self)

#define  bottomToolBarH  50

#define  orderViewMaxHeight 350

#define  getRootView [UIApplication sharedApplication].delegate.window

#define  RColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define  SCFont(s)  [UIFont systemFontOfSize:s]

#endif /* ShopCartMacroColorFont_h */
