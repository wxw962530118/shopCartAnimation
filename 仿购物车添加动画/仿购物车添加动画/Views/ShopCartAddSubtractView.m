//
//  ShopCartAddSubtractView.m
//  仿购物车添加动画
//
//  Created by 王新伟 on 2017/6/24.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "ShopCartAddSubtractView.h"

@interface ShopCartAddSubtractView  ()
/**当前选择的数量*/
@property (nonatomic, strong) UILabel  * currentCountLabel;
/**加号*/
@property (nonatomic, strong) UIButton * addButton;
/**减号*/
@property (nonatomic, strong) UIButton * subtractButton;
/**<#注释#>*/
@property (nonatomic, assign) BOOL isFirst;
@end

@implementation ShopCartAddSubtractView

+(instancetype)createAddSubtractViewWithAddSubtractnClickCallBack:(AddSubtractnClickCallBack)callBack{
    ShopCartAddSubtractView * view = [[ShopCartAddSubtractView alloc]initWithAddSubtractnClickCallBack:callBack];
    return view;
}

-(instancetype )initWithAddSubtractnClickCallBack:(AddSubtractnClickCallBack)callBack{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.callBack = callBack;
        [self loadWithComponents];
    }
    return self;
}

-(void)loadWithComponents{
    [self addAddButton];
    [self addCurrentCountLabel];
    [self addSubtractButton];
}

-(void)addAddButton{
    if (!_addButton) {
        _addButton = [[UIButton alloc]init];
        [_addButton setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_addButton];
        [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right);
            make.centerY.equalTo(self);
        }];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 获取到约束后的控件frame
    [_addButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(self.height);
    }];
    
    [_subtractButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(self.height);
    }];
}

-(void)addCurrentCountLabel{
    if (!_currentCountLabel) {
        _currentCountLabel = [[UILabel alloc]init];
        _currentCountLabel.text = @"1";
        _currentCountLabel.font = SCFont(15);
        _currentCountLabel.textColor = RColor(33,33,33);
        _currentCountLabel.hidden = YES;
        [self addSubview:_currentCountLabel];
        [_currentCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.center);
        }];
    }
}

-(void)addSubtractButton{
    if (!_subtractButton) {
        _subtractButton = [[UIButton alloc]init];
        [_subtractButton setBackgroundImage:[UIImage imageNamed:@"sub"] forState:UIControlStateNormal];
        [_subtractButton addTarget:self action:@selector(subtractButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_subtractButton];
        _subtractButton.hidden = YES;
        [_subtractButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.centerY.equalTo(self);
        }];
    }
}


-(void)setGoodModel:(ShopCartGoodsModel *)goodModel{
    //NSLog(@"%@订单数量--%d--库存量--%d",goodModel.goodsName,goodModel.orderCount,goodModel.goodsStock);
    _goodModel = goodModel;
    _currentCountLabel.text = [NSString stringWithFormat:@"%d",self.goodModel.orderCount];
    if (goodModel.goodsStock == 0 && goodModel.orderCount == 0) {
        _addButton.enabled = NO;
        //默认库存为0 已售完的情况
    }else{
        //用户选择操作后 库存为0 已售完的情况
            if (goodModel.goodsStock == 0 && goodModel.orderCount != 0) {
                _addButton.enabled = NO;
                _subtractButton.hidden = NO;
                _currentCountLabel.hidden = NO;
            }else if(goodModel.orderCount == 0){
                _addButton.enabled = YES;
                _subtractButton.hidden = YES;
                _currentCountLabel.hidden = YES;
            }else{
                _addButton.enabled = YES;
                _subtractButton.hidden = NO;
                _currentCountLabel.hidden = NO;
            }
    }
}

-(void)addButtonClick:(UIButton *)sender{
    if (self.callBack) {
        self.callBack(AddSubtractnType_Add,sender);
    }
}

-(void)subtractButtonClick:(UIButton *)sender{
    if (self.callBack) {
        self.callBack(AddSubtractnType_Subtractn,sender);
    }
}

@end
