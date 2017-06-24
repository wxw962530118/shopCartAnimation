//
//  ShopCartBottomView.m
//  仿购物车添加动画
//
//  Created by 王新伟 on 2017/6/21.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "ShopCartBottomView.h"
#import "ShopCartOrderView.h"
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
/**订单总价*/
@property (nonatomic, assign) double orderSum;
/**订单列表数量*/
@property (nonatomic, assign) NSInteger orderCount;

@end

@implementation ShopCartBottomView

-(instancetype)initWithFrame:(CGRect)frame shopCartSuperView:(UIView *)shopCartSuperView{
    self = [super initWithFrame:frame];
    if (self) {
        self.shopCartSuperView = shopCartSuperView;
        [self loadWithComponents];
    }
    return  self;
}

-(void)loadWithComponents{
    [self addTopLineView];
    [self addShopCartButton];
    [self addTotalPriceLabel];
    [self addCommitButton];
}

-(void)addTopLineView{
    if (!_topLineView) {
        _topLineView = [[UIView alloc]init];
        _topLineView.backgroundColor = RColor(55, 55, 55);
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
        _shopCartButton.tag = 1000;
        [_shopCartButton addTarget:self action:@selector(shopCartButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.shopCartSuperView addSubview:_shopCartButton];
        [_shopCartButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.shopCartSuperView.mas_left).offset(10);
            make.bottom.equalTo(self.shopCartSuperView.mas_bottom).offset(-10);
            make.width.height.mas_equalTo(52);
        }];
    }
}

-(void)addTotalPriceLabel{
    if (!_totalPriceLabel) {
        _totalPriceLabel = [[UILabel alloc]init];
        [self addSubview:_totalPriceLabel];
        [_totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(72);
            make.centerY.equalTo(self);
        }];
    }
}

-(void)addCommitButton{
    if (!_commitButton) {
        _commitButton = [[UIButton alloc]init];
        _commitButton.layer.cornerRadius = 5;
        _commitButton.layer.masksToBounds = YES;
        _commitButton.titleLabel.font = UIFont(15);
        [self addSubview:_commitButton];
        [_commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(84, 30));
        }];
    }
}

-(void)setOrderDataArray:(NSMutableArray<ShopCartGoodsModel *> *)orderDataArray{
    _orderDataArray = orderDataArray;
    for (ShopCartGoodsModel * model in orderDataArray) {
        self.orderSum += model.goodsSalePrice;
    }
    self.orderCount = orderDataArray.count;
    if (!orderDataArray.count) {
        _commitButton.userInteractionEnabled = _shopCartButton.userInteractionEnabled = NO;
        _totalPriceLabel.text = @"购物车空空如也~";
        _totalPriceLabel.textColor = RColor(114, 114, 114);
        _totalPriceLabel.font = UIFont(14);
        _commitButton.backgroundColor = RColor(114, 114, 114);
        [_commitButton setTitle:@"请选择商品" forState:UIControlStateNormal];
        [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        _commitButton.backgroundColor = RColor(252,42, 28);
        [_commitButton setTitle:@"选好了" forState:UIControlStateNormal];
        [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _totalPriceLabel.text = [NSString stringWithFormat:@"共:￥%.2f",self.orderSum];
        _totalPriceLabel.textColor = RColor(252,42, 28);
        _totalPriceLabel.font = UIFont(17);
        _commitButton.userInteractionEnabled = _shopCartButton.userInteractionEnabled = YES;
    }
}

#pragma mark --- 点击了购物车按钮
-(void)shopCartButtonClick{
    [self.shopCartSuperView layoutIfNeeded];
    [UIView animateWithDuration:.6f animations:^{
        [_shopCartButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_shopCartButton.superview.mas_bottom).offset(-10 - (orderViewMaxHeight >= self.orderCount * 44 ? self.orderCount * 44 : orderViewMaxHeight) - bottomToolBarH);
        }];
        
        [_totalPriceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
        }];
        [self.shopCartSuperView layoutIfNeeded];
    }];
    
    __weak typeof(self) weakSelf = self;
    [ShopCartOrderView showShopCartOrderViewWithShopCartSuperView:self.shopCartSuperView goodsModel:self.orderDataArray ShopCartViewBlock:^(NSNumber *selectedCount) {
        if (![selectedCount integerValue]) {
            [self.shopCartSuperView layoutIfNeeded];
            [UIView animateWithDuration:.6f animations:^{
                [_shopCartButton mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(_shopCartButton.superview.mas_bottom).offset(-10);
                }];
                
                [_totalPriceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(weakSelf.mas_left).offset(72);
                }];
                [weakSelf.shopCartSuperView layoutIfNeeded];
            }];
        }
    }];
    [_shopCartButton.superview bringSubviewToFront:_shopCartButton];
}

-(void)dealloc{
    
}

@end
