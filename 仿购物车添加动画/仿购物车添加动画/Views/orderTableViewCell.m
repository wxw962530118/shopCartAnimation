//
//  orderTableViewCell.m
//  仿购物车添加动画
//
//  Created by 王新伟 on 2017/6/21.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "orderTableViewCell.h"
#import "GoodsModel.h"
@interface orderTableViewCell ()
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

@end

@implementation orderTableViewCell

-(void)loadWithComponents{
    [self addLeftLineView];
    [self addNameLabel];
    [self addAddButton];
    [self addCurrentCountLabel];
    [self addSubtractButton];
    [self addCurrentPriceLabel];
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
        _nameLabel.text = @"生产菜市场";
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_leftLineView.mas_right).offset(5);
            make.centerY.equalTo(self.contentView);
        }];
    }
}

-(void)addAddButton{
    if (!_addButton) {
        _addButton = [[UIButton alloc]init];
        [_addButton setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
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
        _currentCountLabel.text = @"33321";
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
        [_subtractButton addTarget:self action:@selector(subtractButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_subtractButton];
        [_subtractButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_currentCountLabel.mas_left).offset(-10);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
    }
}

-(void)addCurrentPriceLabel{
    if (!_currentPriceLabel) {
        _currentPriceLabel = [[UILabel alloc]init];
        _currentPriceLabel.text = @"￥333";
        _currentPriceLabel.textColor = RColor(252,42, 28);
        [self.contentView addSubview:_currentPriceLabel];
        [_currentPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_subtractButton.mas_left).offset(-30);
            make.centerY.equalTo(self.contentView);
        }];
    }
}


-(void)setDataWithModel:(GoodsModel *)model{
    
}

#pragma mark --- 加号按钮事件
-(void)addButtonClick{

}

#pragma mark --- 减号按钮事件
-(void)subtractButtonClick{

}

@end
