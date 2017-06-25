//
//  ShopCartMacroNotifications.h
//  仿购物车添加动画
//
//  Created by 王新伟 on 2017/6/24.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCartMacroNotifications : NSObject

@end

CG_INLINE void NotificationRegister(NSString *name, id observer, SEL selector, id object) {
    
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:name object:object];
}

CG_INLINE void NotificationPost(NSString *name, id object, NSDictionary *userInfo) {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:object userInfo:userInfo];
}

CG_INLINE void NotificationRemove(NSString *name, id observer, id object) {
    
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:name object:object];
}

CG_INLINE void NotificationRemoveAll(id observer) {
    
    [[NSNotificationCenter defaultCenter] removeObserver:observer];
}

/**点击订单列表增加按钮的通知*/
UIKIT_EXTERN NSString * const ORDERLIST_CLICK_ADDBUTTON_NOTIFICATION;
/**点击订单列表增加删除的通知*/
UIKIT_EXTERN NSString * const ORDERLIST_CLICK_SUBTRACT_BUTTON_NOTIFICATION;

/**点击商品列表增加按钮的通知*/
UIKIT_EXTERN NSString * const SHOPCARTLIST_CLICK_ADDBUTTON_NOTIFICATION;
/**点击商品列表增加删除的通知*/
UIKIT_EXTERN NSString * const SHOPCARTLIST_CLICK_SUBTRACT_BUTTON_NOTIFICATION;
