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
/**商品图标*/
@property (nonatomic, strong) UIImageView * leftImageView;
/**商品名称*/
@property (nonatomic, strong) UILabel * nameLabel;
/**原价*/
@property (nonatomic, strong) UILabel * originalPrice;
/**现价*/
@property (nonatomic, strong) UILabel * currentPrice;
/**已售完图标*/
@property (nonatomic, strong) UIImageView * soldoutImageView;
/**底部分割线*/
@property (nonatomic, strong) UIView * bottomLineView;
@end

@implementation rightTableViewCell

-(void)loadWithComponents{
    [self addLeftImageView];
    [self addNameLabel];
    [self addOriginalPrice];
    [self addCurrentPrice];
    [self addSoldoutImageView];
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
            make.top.equalTo(self.contentView.mas_top).offset(8);
        }];
        
    }
}

-(void)addOriginalPrice{
    if (!_originalPrice) {
        _originalPrice = [[UILabel alloc]init];
        _originalPrice.font = UIFont(13);
        _originalPrice.textColor = RColor(114, 114, 114);
        [self.contentView addSubview:_originalPrice];
        [_originalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_leftImageView.mas_right).offset(10);
            make.centerY.equalTo(self.contentView);
        }];
    }
}

-(void)addCurrentPrice{
    if (!_currentPrice) {
        _currentPrice = [[UILabel alloc]init];
        _currentPrice.font = UIFont(17);
        _currentPrice.textColor = RColor(253,103, 105);
        [self.contentView addSubview:_currentPrice];
        [_currentPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_leftImageView.mas_right).offset(10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-8);
        }];
    }
}

-(void)addSoldoutImageView{
    if (!_soldoutImageView) {
        _soldoutImageView = [[UIImageView alloc]init];
        _soldoutImageView.image = [UIImage imageNamed:@"icon_soldout"];
        [self.contentView addSubview:_soldoutImageView];
        [_soldoutImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(75,46));
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
    _leftImageView.image = [UIImage imageNamed:model.goodsIcon];
}

@end
