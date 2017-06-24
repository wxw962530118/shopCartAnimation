//
//  ShopCartGoodsCategoryCell.m
//  仿购物车添加动画
//
//  Created by 王新伟 on 2017/6/24.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "ShopCartGoodsCategoryCell.h"

@interface ShopCartGoodsCategoryCell ()
/**左侧示意条*/
@property (nonatomic, strong) UIView * leftLineView;
/**选中背景*/
@property (nonatomic, strong) UIView * selectedBgView;

@end

@implementation ShopCartGoodsCategoryCell

-(void)loadWithComponents{
    self.backgroundColor = RColor(240, 240, 240);
    [self addSelectedBgView];
    [self addLeftLineView];
}

-(void)addSelectedBgView{
    if (!_selectedBgView) {
        _selectedBgView = [[UIView alloc] initWithFrame:self.frame];
        _selectedBgView.backgroundColor = [UIColor whiteColor];
        self.selectedBackgroundView = _selectedBgView;
    }
}

-(void)addLeftLineView{
    if (!_leftLineView) {
        _leftLineView = [[UIView alloc]init];
        _leftLineView.backgroundColor = [UIColor orangeColor];
        [_selectedBgView addSubview:_leftLineView];
        [_leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_selectedBgView.mas_top);
            make.left.equalTo(_selectedBgView.mas_left);
            make.bottom.equalTo(_selectedBgView.mas_bottom);
            make.width.mas_equalTo(6);
        }];
    }
}

-(void)setDataWithModel:(ShopCartGoodsCategoryModel *)model{
    self.textLabel.text = model.goodsCategoryName;
}


@end
