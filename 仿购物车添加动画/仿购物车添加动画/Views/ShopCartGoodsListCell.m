//
//  ShopCartGoodsListCell.m
//  仿购物车添加动画
//
//  Created by 王新伟 on 2017/6/24.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "ShopCartGoodsListCell.h"
#import "ShopCartAddSubtractView.h"
@interface ShopCartGoodsListCell ()
/**商品图标*/
@property (nonatomic, strong) UIImageView * leftImageView;
/**商品名称*/
@property (nonatomic, strong) UILabel * nameLabel;
/**原价*/
@property (nonatomic, strong) UILabel * originalPriceLabel;
/**现价*/
@property (nonatomic, strong) UILabel * currentPriceLabel;
/**已售完图标*/
@property (nonatomic, strong) UIImageView * soldoutImageView;
/**底部分割线*/
@property (nonatomic, strong) UIView * bottomLineView;
/***/
@property (nonatomic, strong) ShopCartAddSubtractView * addSubtractView;
/***/
@property (nonatomic, strong) ShopCartGoodsModel * goodModel;

@end

@implementation ShopCartGoodsListCell

-(void)loadWithComponents{
    [self addLeftImageView];
    [self addNameLabel];
    [self addOriginalPriceLabel];
    [self addCurrentPriceLabel];
    [self addSoldoutImageView];
    [self addShopCartAddSubtractView];
    [self addBottomLineView];
}

-(void)addLeftImageView{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_leftImageView];
        [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.top.equalTo(self.contentView.mas_top).offset(5);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
            make.width.height.mas_equalTo(60);
        }];
    }
}

-(void)addNameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = SCFont(18);
        _nameLabel.textColor = RColor(33, 33, 33);
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_leftImageView.mas_right).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-5);
            make.top.equalTo(self.contentView.mas_top).offset(5);
        }];
    }
}

-(void)addOriginalPriceLabel{
    if (!_originalPriceLabel) {
        _originalPriceLabel = [[UILabel alloc]init];
        _originalPriceLabel.font = SCFont(13);
        _originalPriceLabel.textColor = RColor(114, 114, 114);
        [self.contentView addSubview:_originalPriceLabel];
        [_originalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_leftImageView.mas_right).offset(10);
            make.centerY.equalTo(self.contentView);
        }];
    }
}

-(void)addCurrentPriceLabel{
    if (!_currentPriceLabel) {
        _currentPriceLabel = [[UILabel alloc]init];
        _currentPriceLabel.font = SCFont(17);
        _currentPriceLabel.textColor = RColor(252,42, 28);
        [self.contentView addSubview:_currentPriceLabel];
        [_currentPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_leftImageView.mas_right).offset(10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        }];
    }
}

-(void)addSoldoutImageView{
    if (!_soldoutImageView) {
        _soldoutImageView = [[UIImageView alloc]init];
        _soldoutImageView.hidden = YES;
        _soldoutImageView.image = [UIImage imageNamed:@"icon_soldout"];
        [self.contentView addSubview:_soldoutImageView];
        [_soldoutImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(75,46));
        }];
    }
}

-(void)addShopCartAddSubtractView{
    if (!_addSubtractView) {
        __weak typeof(self) weakSelf = self;
        _addSubtractView = [ShopCartAddSubtractView createAddSubtractViewWithAddSubtractnClickCallBack:^(AddSubtractnType type, UIButton * sender) {
            switch (type) {
                case AddSubtractnType_Add:
                    weakSelf.goodModel.goodsStock--;
                    weakSelf.goodModel.orderCount++;
                    if (weakSelf.goodModel.goodsStock == 0) {
                        _soldoutImageView.hidden = NO;
                    }
                    NotificationPost(SHOPCARTLIST_CLICK_ADDBUTTON_NOTIFICATION, nil, @{@"ShopCartGoodsListCell":weakSelf,@"sender":sender});
                    break;
                    
                case AddSubtractnType_Subtractn:
                    weakSelf.goodModel.goodsStock++;
                    weakSelf.goodModel.orderCount--;
                    if (weakSelf.goodModel.goodsStock > 0) {
                        _soldoutImageView.hidden = YES;
                    }
                    NotificationPost(SHOPCARTLIST_CLICK_SUBTRACT_BUTTON_NOTIFICATION, nil, @{@"ShopCartGoodsListCell":weakSelf,@"sender":sender});
                    break;
                    
                default:
                    break;
            }
        }];
        [self.contentView addSubview:_addSubtractView];
        [_addSubtractView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.size.mas_equalTo(CGSizeMake(74, 20));
        }];
    }
}

-(void)addBottomLineView{
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc]init];
        _bottomLineView.backgroundColor = RColor(224, 224, 224);
        [self.contentView addSubview:_bottomLineView];
        [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_leftImageView);
            make.right.equalTo(self.contentView);
            make.bottom.equalTo(self.mas_bottom);
            make.height.mas_equalTo(.5f);
        }];
    }
}

-(void)setDataWithModel:(ShopCartGoodsModel *)model{
    self.goodModel = model;
    _addSubtractView.goodModel = self.goodModel;
    if (model.goodsStock == 0){
        _soldoutImageView.hidden = NO;
    }else{
        _soldoutImageView.hidden = YES;
    }
    _leftImageView.image = [UIImage imageNamed:model.goodsIcon];
    _nameLabel.text = model.goodsName;
    _originalPriceLabel.text = [NSString stringWithFormat:@"原价: ￥%.2f",model.goodsOriginalPrice];
    _currentPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",model.goodsSalePrice];
}

@end
