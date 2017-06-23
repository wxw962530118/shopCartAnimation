//
//  SCThrowLineTools.m
//  仿购物车添加动画
//
//  Created by 王新伟 on 2017/6/23.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "SCThrowLineTools.h"
#import <QuartzCore/QuartzCore.h>

@interface SCThrowLineTools ()<CAAnimationDelegate>
/**被抛出对象*/
@property (nonatomic, strong) UIView * throwLineView;
@end

@implementation SCThrowLineTools

+(instancetype)shareInstance{
    static SCThrowLineTools * tools = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[SCThrowLineTools alloc]init];
    });
    return tools;
}

-(void)throwWithObject:(UIView *)obj from:(CGPoint)startPoint to:(CGPoint)endPoint{
    self.throwLineView = obj;
    [self groupAnimationWithStartPoint:startPoint endPoint:endPoint];
}


+(instancetype)createSCThrowLineWithObject:(UIView *)obj from:(CGPoint)startPoint to:(CGPoint)endPoint animationFinishedBlock:(ThrowLineAnimationFinished)animationFinishedBlock{
    SCThrowLineTools * tools = [[SCThrowLineTools alloc]initWithObject:obj from:startPoint to:endPoint animationFinishedBlock:animationFinishedBlock];
    return tools;
}

-(instancetype)initWithObject:(UIView *)obj from:(CGPoint)startPoint to:(CGPoint)endPoint animationFinishedBlock:(ThrowLineAnimationFinished)animationFinishedBlock{
    self = [super init];
    if (self) {
        self.throwLineView = obj;
        self.animationFinishedBlock = animationFinishedBlock;
        [self groupAnimationWithStartPoint:startPoint endPoint:endPoint];
    }
    return self;
}


#pragma mark --- 组合动画
-(void)groupAnimationWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    UIBezierPath * path= [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(startPoint.x, startPoint.y)];
    //三点曲线
    [path addCurveToPoint:CGPointMake(endPoint.x+25, endPoint.y+25)
            controlPoint1:CGPointMake(startPoint.x, startPoint.y)
            controlPoint2:CGPointMake(startPoint.x - 180, startPoint.y - 200)];
    
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation * alphaAnimation = [CABasicAnimation animationWithKeyPath:@"alpha"];
    alphaAnimation.duration = 0.8f;
    alphaAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    alphaAnimation.toValue = [NSNumber numberWithFloat:0.1];
    alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup * groups = [CAAnimationGroup animation];
    groups.animations = @[animation,alphaAnimation];
    groups.duration = 0.5f;
    groups.removedOnCompletion = NO;
    groups.fillMode = kCAFillModeForwards;
    groups.delegate = self;
    [groups setValue:@"groupsAnimation" forKey:@"animationName"];
    [self.throwLineView.layer addAnimation:groups forKey:@"position scale"];
}

#pragma mark --- 动画结束的代理
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (self.animationFinishedBlock) {
        self.animationFinishedBlock();
    }
    self.throwLineView = nil;
}
@end
