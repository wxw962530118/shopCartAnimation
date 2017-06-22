//
//  ShopCartBottomView.m
//  仿购物车添加动画
//
//  Created by 王新伟 on 2017/6/21.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "ShopCartBottomView.h"
#import "orderTableViewCell.h"
#import "ShopCartView.h"
@interface ShopCartBottomView ()
/**购物车按钮*/
@property (nonatomic, strong) UIButton * shopCartButton;
/**上面分割线*/
@property (nonatomic, strong) UIView * topLineView;
/**确认按钮*/
@property (nonatomic, strong) UIButton * commitButton;
/**总价*/
@property (nonatomic, strong) UILabel * totalPriceLabel;
/**当前的父视图*/
@property (nonatomic, strong) UIView * shopCartSuperView;

@end

@implementation ShopCartBottomView

-(instancetype)initWithFrame:(CGRect)frame shopCartSuperView:(UIView *)shopCartSuperView{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
        self.shopCartSuperView = shopCartSuperView;
        [self loadWithComponents];
    }
    return  self;
}

-(void)loadWithComponents{
    [self addTopLineView];
    [self addShopCartButton];
}

-(void)addTopLineView{
    if (!_topLineView) {
        _topLineView = [[UIView alloc]init];
        _topLineView.backgroundColor = RColor(33, 33, 33);
        [self addSubview:_topLineView];
        [_topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(self);
            make.height.mas_equalTo(.5f);
        }];
    }
}

-(void)addShopCartButton{
    if (!_shopCartButton) {
        _shopCartButton = [[UIButton alloc]init];
        [_shopCartButton setBackgroundImage:[UIImage imageNamed:@"gouwuche"] forState:UIControlStateNormal];
        [_shopCartButton addTarget:self action:@selector(shopCartButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.shopCartSuperView addSubview:_shopCartButton];
        [_shopCartButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.shopCartSuperView.mas_left).offset(10);
            make.bottom.equalTo(self.shopCartSuperView.mas_bottom).offset(-10);
            make.width.height.mas_equalTo(52);
        }];
    }
}


#pragma mark --- 点击了购物车按钮
-(void)shopCartButtonClick{
    [_shopCartButton.superview layoutIfNeeded];
    [UIView animateWithDuration:.6f animations:^{
        [_shopCartButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.superview.mas_bottom).offset(-10- 3 * 44 - 52);
        }];
         [_shopCartButton.superview layoutIfNeeded];
    }];
    
    __weak typeof(self) weakSelf = self;
    [ShopCartView ShowShopCartViewWithShopCartSuperView:self.shopCartSuperView ShopCartViewBlock:^(NSNumber * selectedCount) {
        if (![selectedCount integerValue]) {
            [_shopCartButton.superview layoutIfNeeded];
            [UIView animateWithDuration:.6f animations:^{
                [_shopCartButton mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(weakSelf.superview.mas_bottom).offset(-10);
                }];
                [_shopCartButton.superview layoutIfNeeded];
            }];
        }
    }];
    [_shopCartButton.superview bringSubviewToFront:_shopCartButton];
}

-(void)dealloc{

}

@end
