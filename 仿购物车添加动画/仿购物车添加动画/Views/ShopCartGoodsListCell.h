//
//  ShopCartGoodsListCell.h
//  仿购物车添加动画
//
//  Created by 王新伟 on 2017/6/24.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger , AddSubtractnType){
    AddSubtractnType_Add,
    AddSubtractnType_Subtractn
};

/**
 加减按钮的回调
 
 @param type 点击按钮的类型
 @param sender 被点击对象
 */
typedef void(^AddSubtractnClickCallBack)(AddSubtractnType type,UIButton * sender);

@interface ShopCartGoodsListCell : UITableViewCell
/***/
@property (nonatomic, copy) AddSubtractnClickCallBack callBack;

@end
