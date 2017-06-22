//
//  rightTableViewCell.h
//  仿购物车添加动画
//
//  Created by 王新伟 on 2017/6/21.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger , AddSubtractnType){
    AddSubtractnType_Add,
    AddSubtractnType_Subtractn
};

typedef void(^AddSubtractnClickCallBack)(AddSubtractnType type);

@interface rightTableViewCell : UITableViewCell
/***/
@property (nonatomic, copy) AddSubtractnClickCallBack callBack;

@end
