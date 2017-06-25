//
//  ShopCartOrderCell.m
//  仿购物车添加动画
//
//  Created by 王新伟 on 2017/6/24.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "ShopCartOrderCell.h"
#import "ShopCartAddSubtractView.h"
@interface ShopCartOrderCell ()
/**左边示意条*/
@property (nonatomic, strong) UIView * leftLineView;
/**名称*/
@property (nonatomic, strong) UILabel * nameLabel;
/**现在价格*/
@property (nonatomic, strong) UILabel * currentPriceLabel;
/**加号*/
@property (nonatomic, strong) UIButton * addButton;
/**减号*/
@property (nonatomic, strong) UIButton * subtractButton;
/**当前选择的数量*/
@property (nonatomic, strong) UILabel * currentCountLabel;
/***/
@property (nonatomic, strong) ShopCartGoodsModel * goodsModel;
/***/
@property (nonatomic, strong) ShopCartAddSubtractView * addSubtractView;

@end

@implementation ShopCartOrderCell

-(void)loadWithComponents{
    [self addLeftLineView];
    [self addShopCartAddSubtractView];
    [self addCurrentPriceLabel];
    [self addNameLabel];
}

-(void)addLeftLineView{
    if (!_leftLineView) {
        _leftLineView = [[UIView alloc]init];
        _leftLineView.backgroundColor = RColor(253,103, 105);
        [self.contentView addSubview:_leftLineView];
        [_leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(5);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(3,20));
        }];
    }
}

-(void)addNameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = RColor(33,33,33);
        _nameLabel.numberOfLines = 2;
        _nameLabel.font = SCFont(16);
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_leftLineView.mas_right).offset(5);
            make.right.equalTo(_currentPriceLabel.mas_left).offset(-10);
            make.centerY.equalTo(self.contentView);
        }];
    }
}
-(void)addShopCartAddSubtractView{
    if (!_addSubtractView) {
        __weak typeof(self) weakSelf = self;
        _addSubtractView = [ShopCartAddSubtractView createAddSubtractViewWithAddSubtractnClickCallBack:^(AddSubtractnType type, UIButton *sender) {
            switch (type) {
                case AddSubtractnType_Add:
                    weakSelf.goodsModel.goodsStock--;
                    weakSelf.goodsModel.orderCount++;
                    NotificationPost(ORDERLIST_CLICK_ADDBUTTON_NOTIFICATION, nil, @{@"ShopCartOrderCell":weakSelf});
                    break;
                    
                case AddSubtractnType_Subtractn:
                    weakSelf.goodsModel.goodsStock++;
                    weakSelf.goodsModel.orderCount--;
                    if (weakSelf.goodsModel.goodsStock > 0) {
                    }
                    NotificationPost(ORDERLIST_CLICK_SUBTRACT_BUTTON_NOTIFICATION, nil,@{@"ShopCartOrderCell":weakSelf});
                    break;
                    
                default:
                    break;
            }
        }];
        [self.contentView addSubview:_addSubtractView];
        [_addSubtractView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.size.mas_equalTo(CGSizeMake(64,15));
        }];
    }
}


-(void)addCurrentPriceLabel{
    if (!_currentPriceLabel) {
        _currentPriceLabel = [[UILabel alloc]init];
        _currentPriceLabel.textAlignment = NSTextAlignmentLeft;
        _currentPriceLabel.textColor = RColor(252,42, 28);
        [self.contentView addSubview:_currentPriceLabel];
        [_currentPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_addSubtractView.mas_left).offset(-15);
            make.width.mas_equalTo(70);
            make.centerY.equalTo(self.contentView);
        }];
    }
}

-(void)setDataWithModel:(ShopCartGoodsModel *)model{
    self.goodsModel = model;
    _addSubtractView.goodModel = self.goodsModel;
    _nameLabel.text = model.goodsName;
    _currentCountLabel.text = [NSString stringWithFormat:@"%d",model.orderCount];
    _currentPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",model.goodsSalePrice];
}

@end
