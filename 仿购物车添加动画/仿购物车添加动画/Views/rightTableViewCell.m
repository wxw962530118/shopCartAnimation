//
//  rightTableViewCell.m
//  仿购物车添加动画
//
//  Created by 王新伟 on 2017/6/21.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "rightTableViewCell.h"
#import "GoodsModel.h"

@interface rightTableViewCell ()
/***/
@property (nonatomic, copy) AddSubtractnClickCallBack Block;
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
/**当前选择的数量*/
@property (nonatomic, strong) UILabel * currentCountLabel;
/**加号*/
@property (nonatomic, strong) UIButton * addButton;
/**减号*/
@property (nonatomic, strong) UIButton * subtractButton;
/***/
@property (nonatomic, strong) GoodsModel * goodModel;
@end

@implementation rightTableViewCell

-(void)loadWithComponents{
    [self addLeftImageView];
    [self addNameLabel];
    [self addOriginalPriceLabel];
    [self addCurrentPriceLabel];
    [self addSoldoutImageView];
    [self addAddButton];
    [self addCurrentCountLabel];
    [self addSubtractButton];
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
        _nameLabel.font = UIFont(18);
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
        _originalPriceLabel.font = UIFont(13);
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
        _currentPriceLabel.font = UIFont(17);
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

-(void)addAddButton{
    if (!_addButton) {
        _addButton = [[UIButton alloc]init];
        [_addButton setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_addButton];
        [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
    }
}

-(void)addCurrentCountLabel{
    if (!_currentCountLabel) {
        _currentCountLabel = [[UILabel alloc]init];
        _currentCountLabel.text = @"1";
        _currentCountLabel.textColor = RColor(33,33,33);
        [self.contentView addSubview:_currentCountLabel];
        [_currentCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_addButton.mas_left).offset(-10);
            make.centerY.equalTo(self.contentView);
        }];
    }
}

-(void)addSubtractButton{
    if (!_subtractButton) {
        _subtractButton = [[UIButton alloc]init];
        [_subtractButton setBackgroundImage:[UIImage imageNamed:@"sub"] forState:UIControlStateNormal];
        [_subtractButton addTarget:self action:@selector(subtractButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_subtractButton];
        [_subtractButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_currentCountLabel.mas_left).offset(-10);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(20, 20));
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

-(void)setDataWithModel:(GoodsModel *)model{
    self.goodModel = model;
    if (model.goodsStock == 0){
        _addButton.enabled = NO;
        _subtractButton.hidden = YES;
        _soldoutImageView.hidden = NO;
        _currentCountLabel.text = @"";
    }else{
        _addButton.enabled = YES;
        _soldoutImageView.hidden = YES;
        if (self.goodModel.orderCount == 0) {
            _subtractButton.hidden = YES;
            _currentCountLabel.text = @"";
        }else{
            _subtractButton.hidden = NO;
            _currentCountLabel.text = [NSString stringWithFormat:@"%d",self.goodModel.orderCount];
        }
    }
    _leftImageView.image = [UIImage imageNamed:model.goodsIcon];
    _nameLabel.text = model.goodsName;
    _originalPriceLabel.text = [NSString stringWithFormat:@"原价: ￥%.2f",model.goodsOriginalPrice];
    _currentPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",model.goodsSalePrice];
}

#pragma mark --- 加号按钮事件
-(void)addButtonClick:(UIButton *)sender{
    self.goodModel.goodsStock--;
    self.goodModel.orderCount++;
    _currentCountLabel.text = [NSString stringWithFormat:@"%d",self.goodModel.orderCount];
    _subtractButton.hidden = NO;
    if (self.goodModel.goodsStock == 0) {
        _soldoutImageView.hidden = NO;
        _addButton.enabled = NO;
    }
    if (self.callBack) {
        self.callBack(AddSubtractnType_Add,sender);
    }
}

#pragma mark --- 减号按钮事件
-(void)subtractButtonClick:(UIButton *)sender{
    self.goodModel.goodsStock++;
    self.goodModel.orderCount--;
    _soldoutImageView.hidden = YES;
    _currentCountLabel.text = [NSString stringWithFormat:@"%d",self.goodModel.orderCount];
    if (self.goodModel.orderCount == 0) {
        _subtractButton.hidden = YES;
        _currentCountLabel.text = @"";
    }
    
    if (self.goodModel.goodsStock > 0) {
        _soldoutImageView.hidden = YES;
        _addButton.enabled = YES;
    }
    
    if (self.callBack) {
        self.callBack(AddSubtractnType_Subtractn,sender);
    }
}

@end
