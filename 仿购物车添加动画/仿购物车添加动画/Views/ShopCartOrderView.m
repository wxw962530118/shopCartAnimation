//
//  ShopCartOrderView.m
//  仿购物车添加动画
//
//  Created by 王新伟 on 2017/6/24.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "ShopCartOrderView.h"
#import "ShopCartOrderCell.h"
@interface ShopCartOrderView ()<UITableViewDelegate,UITableViewDataSource>
/**表格*/
@property (nonatomic, strong) UITableView * orderTableView;
/***/
@property (nonatomic, copy) ShopCartViewBlock Block;
/***/
@property (nonatomic, strong) UIView * shopCartSuperView;
/**订单数据源*/
@property (nonatomic, strong) NSMutableArray<ShopCartGoodsModel *> * goodsModelArray;

@end

@implementation ShopCartOrderView

+(instancetype )showShopCartOrderViewWithShopCartSuperView:(UIView *)shopCartSuperView  goodsModel:(NSMutableArray <ShopCartGoodsModel *>*)goodsModelArray ShopCartViewBlock:(ShopCartViewBlock)callBack{
    ShopCartOrderView * view = [[ShopCartOrderView alloc]initWithShopCartSuperView:shopCartSuperView goodsModel:goodsModelArray ShopCartViewBlock:callBack];
    return view;
}

-(instancetype )initWithShopCartSuperView:(UIView *)shopCartSuperView goodsModel:(NSMutableArray <ShopCartGoodsModel *>*)goodsModelArray ShopCartViewBlock:(ShopCartViewBlock)callBack{
    self = [super init];
    if (self) {
        [self addObservers];
        self.Block = callBack;
        self.shopCartSuperView = shopCartSuperView;
        self.goodsModelArray = goodsModelArray;
        [self loadWithComponents];
    }
    return self;
}

-(void)addObservers{
    NotificationRegister(ORDERLIST_CLICK_ADD_BUTTON_NOTIFICATION,self,@selector(addBtnClick:),nil);
    NotificationRegister(ORDERLIST_CLICK_SUBTRACT_BUTTON_NOTIFICATION,self,@selector(subtractBtnClick:),nil);
}

-(void)addBtnClick:(NSNotification *)noti{
    if (self.Block) {
        self.Block(NO,YES,self.goodsModelArray);
    }
    [self.orderTableView reloadData];
}

-(void)subtractBtnClick:(NSNotification *)noti{
    NSIndexPath * indexPath = [self.orderTableView indexPathForCell:(ShopCartOrderCell *)[noti.userInfo objectForKey:@"ShopCartOrderCell"]];
    if (self.goodsModelArray.count) {
        if (!self.goodsModelArray[indexPath.row].orderCount) {
            [self.goodsModelArray removeObject:self.goodsModelArray[indexPath.row]];
            NSInteger  orderCount = self.goodsModelArray.count;
            [self.orderTableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(orderCount * 44);
            }];
        }
        if (self.Block) {
            self.Block(NO,NO,self.goodsModelArray);
        }
    }

    if (!self.goodsModelArray.count) {
        [self hideShopCartView];
    }
    [self.orderTableView reloadData];
}

-(void)loadWithComponents{
    [self.shopCartSuperView addSubview:self];
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shopCartSuperView.mas_top).offset(64);
        make.bottom.equalTo(self.shopCartSuperView.mas_bottom).offset(-bottomToolBarH);
        make.width.mas_equalTo(ScreenWidth);
    }];
    
    [self.shopCartSuperView addSubview:self.orderTableView];
    self.orderTableView.scrollEnabled = !(orderViewMaxHeight >= self.goodsModelArray.count * 44);
    [self.orderTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(orderViewMaxHeight >= self.goodsModelArray.count * 44 ? self.goodsModelArray.count * 44 : orderViewMaxHeight);
        make.bottom.equalTo(self.orderTableView.superview.mas_bottom).offset(-bottomToolBarH);
    }];
    
    [UIView animateWithDuration:.6f animations:^{
        self.orderTableView.alpha = 1;
        self.alpha = .6f;
    }];
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideShopCartView)]];
    
}

-(UITableView *)orderTableView{
    if (!_orderTableView) {
        _orderTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 200, ScreenWidth, 100) style:UITableViewStylePlain];
        _orderTableView.backgroundColor = [UIColor whiteColor];
        _orderTableView.delegate = self;
        _orderTableView.dataSource = self;
        _orderTableView.alpha = 0;
    }
    return _orderTableView;
}

#pragma mark  --- 表格代理及数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.goodsModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShopCartOrderCell * cell = [ShopCartOrderCell cellWithTableView:tableView];
    [cell setDataWithModel:self.goodsModelArray[indexPath.row]];
    return cell;
}

-(CGFloat )tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark --- 黑色遮罩事件
-(void)hideShopCartView{
    if (self.Block) {
        self.Block(YES,NO,self.goodsModelArray);
    }
    [UIView animateWithDuration:.6f animations:^{
        self.orderTableView.alpha = 0;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self.orderTableView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

-(void)dealloc{
    NotificationRemoveAll(self);
}

@end
