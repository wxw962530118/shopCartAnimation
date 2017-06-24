//
//  ShopCartThrowLineTools.h
//  仿购物车添加动画
//
//  Created by 王新伟 on 2017/6/24.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 抛物线结束 的回调
 */
typedef void(^ShopCartThrowLineAnimationFinished)(void);

@interface ShopCartThrowLineTools : NSObject

/**单利构建抛物线工具类  和 对象方法组合使用*/
+(instancetype)shareInstance;

/**
 将一个UIView 从起点抛至终点
 
 @param obj 当前被抛出对象
 @param startPoint 开始点
 @param endPoint 结束点
 */
- (void)throwWithObject:(UIView *)obj from:(CGPoint)startPoint to:(CGPoint)endPoint;

/***/
@property (nonatomic, copy) ShopCartThrowLineAnimationFinished  animationFinishedBlock;


/**
 类方法构建抛物线
 
 @param obj 当前被抛出对象
 @param startPoint 开始点
 @param endPoint 结束点
 @param animationFinishedBlock 抛出结束的回调
 */

+(instancetype)createSCThrowLineWithObject:(UIView *)obj from:(CGPoint)startPoint to:(CGPoint)endPoint animationFinishedBlock:(ShopCartThrowLineAnimationFinished )animationFinishedBlock;

@end
