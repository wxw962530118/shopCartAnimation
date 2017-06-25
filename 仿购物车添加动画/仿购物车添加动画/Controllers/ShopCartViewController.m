//
//  ShopCartViewController.m
//  仿购物车添加动画
//
//  Created by 王新伟 on 2017/6/24.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "ShopCartViewController.h"
#import "ShopCartGoodsCategoryCell.h"
#import "ShopCartGoodsListCell.h"
#import "ShopCartBottomView.h"
#import "ShopCartThrowLineTools.h"
@interface ShopCartViewController ()
<UITableViewDelegate,UITableViewDataSource>
/**左边的商品类别*/
@property (nonatomic, strong) UITableView * leftTableView;
/**右边的详细商品内容*/
@property (nonatomic, strong) UITableView * rightTableView;
/**本地解析的数据源*/
@property (nonatomic, strong) NSArray <ShopCartGoodsCategoryModel *> * dataArray;
/**是否关联*/
@property (nonatomic, assign) BOOL isRelate;
/**底部的购物车*/
@property (nonatomic, strong) ShopCartBottomView * bottomView;
/**订单所选总数量*/
@property (nonatomic, assign) NSInteger totalOrderCount;
/** 订单总价 */
@property (assign, nonatomic) double totalPrice;
/**点击添加按钮抛出的view*/
@property (nonatomic, strong) UIImageView * throwImageView;

@end

@implementation ShopCartViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addObservers];
    [self loadData];
    [self createUI];
}

#pragma mark --- 添加订单列表的增删按钮事件监听
-(void)addObservers{
    NotificationRegister(SHOPCARTLIST_CLICK_ADDBUTTON_NOTIFICATION, self, @selector(clickAddBtn:), nil);
    NotificationRegister(SHOPCARTLIST_CLICK_SUBTRACT_BUTTON_NOTIFICATION, self, @selector(clickSubtractBtn:), nil);
    NotificationRegister(ORDERLIST_CLICK_ADDBUTTON_NOTIFICATION, self,@selector(orderClickAddBtn:), nil);
    NotificationRegister(ORDERLIST_CLICK_SUBTRACT_BUTTON_NOTIFICATION, self,@selector(orderClickSubtractBtn:), nil);
}

-(void)orderClickAddBtn:(NSNotification *)noti{
    [self.rightTableView reloadData];
}

-(void)orderClickSubtractBtn:(NSNotification *)noti{
     [self.rightTableView reloadData];
}

-(void)clickAddBtn:(NSNotification *)noti{
    [self addBtnClickd:(NSIndexPath *)[self.rightTableView indexPathForCell:(ShopCartGoodsListCell *)[noti.userInfo objectForKey:@"ShopCartGoodsListCell"]] clickBtn:(UIButton *)[noti.userInfo objectForKey:@"sender"]];
}

-(void)clickSubtractBtn:(NSNotification *)noti{
    [self subtractnBtnClickd:(NSIndexPath *)[self.rightTableView indexPathForCell:(ShopCartGoodsListCell *)[noti.userInfo objectForKey:@"ShopCartGoodsListCell"]] clickBtn:(UIButton *)[noti.userInfo objectForKey:@"sender"]];
}

-(void)reloadData{
    [self.rightTableView reloadData];
}

-(void)createUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"购物车";
    [self.view addSubview:self.bottomView];
    [self.view sendSubviewToBack:self.bottomView];
}

#pragma mark --- 获取商品数据
- (void)loadData {
    self.isRelate = YES;
    NSError * error = nil;
    NSData  * data = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"goods" ofType:@"json"]];
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:data
                                                   options:NSJSONReadingAllowFragments
                                                     error:&error];
    self.dataArray = [ShopCartGoodsCategoryModel mj_objectArrayWithKeyValuesArray:arr];
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
    //默认选中
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    if (error) {
        NSLog(@"解析出错:%@", error.description);
    }
}

#pragma mark --- 表格代理及数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.leftTableView) {
        return 1;
    }else{
        return [self.dataArray count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return self.dataArray.count;
    }else{
        return self.dataArray[section].goodsArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        ShopCartGoodsCategoryCell * cell = [ShopCartGoodsCategoryCell cellWithTableView:tableView];
        [cell setDataWithModel:self.dataArray[indexPath.row]];
        return cell;
    }else{
        ShopCartGoodsListCell * cell = [ShopCartGoodsListCell cellWithTableView:tableView];
        [cell setDataWithModel:self.dataArray[indexPath.section].goodsArray[indexPath.row]];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.rightTableView) {
        return 30;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (tableView == self.rightTableView) {
        return 0.01;
    } else {
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

//返回组头部的那块View
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == self.rightTableView) {
        UIView * view = [[UIView alloc]init];
        view.frame = CGRectMake(0, 0, ScreenWidth, 30);
        view.backgroundColor = RColor(240, 240, 240);
        [view setAlpha:0.8];
        UILabel * label = [[UILabel alloc]initWithFrame:view.bounds];
        [label setText:[NSString stringWithFormat:@"  %@",[self.dataArray objectAtIndex:section].goodsCategoryDesc]];
        [view addSubview:label];
        return view;
    } else {
        return nil;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        _isRelate = NO;
        [self.leftTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
        //点击了左边的cell 让右边的tableView跟着滚动
        [self.rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }else{
        [self.rightTableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (self.isRelate) {
        NSInteger topCellSection = [[[tableView indexPathsForVisibleRows] firstObject] section];
        if (tableView == self.rightTableView) {
            [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    if (self.isRelate) {
        NSInteger topCellSection = [[[tableView indexPathsForVisibleRows] firstObject] section];
        if (tableView == self.rightTableView) {
            [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}

#pragma mark --- UISCrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    self.isRelate = YES;
}

#pragma mark --- Lzay
-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

-(NSMutableArray *)orderArray{
    if (!_orderArray) {
        _orderArray = [NSMutableArray array];
    }
    return _orderArray;
}

-(UITableView *)leftTableView{
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_leftTableView];
        [_leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(64);
            make.bottom.equalTo(self.view.mas_bottom).offset(-bottomToolBarH);
            make.left.equalTo(self.view);
            make.width.mas_offset(ScreenWidth * .25f);
        }];
    }
    return _leftTableView;
}

-(UITableView *)rightTableView{
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_rightTableView];
        [_rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(64);
            make.bottom.equalTo(self.view.mas_bottom).offset(-bottomToolBarH);
            make.left.equalTo(_leftTableView.mas_right);
            make.width.mas_offset(ScreenWidth * .75f);
        }];
    }
    return _rightTableView;
}

-(ShopCartBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[ShopCartBottomView alloc]initWithFrame:CGRectMake(0,ScreenHeight - bottomToolBarH, ScreenWidth, bottomToolBarH) shopCartSuperView:self.view];
        _bottomView.orderDataArray = self.orderArray;
    }
    return _bottomView;
}

-(UIImageView *)throwImageView{
    if (!_throwImageView) {
        _throwImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _throwImageView.image = [UIImage imageNamed:@"adddetail"];
        _throwImageView.layer.cornerRadius = 10;
    }
    return _throwImageView;
}

#pragma mark --- 购物车右侧列表的增加删减按钮事件
-(void)addBtnClickd:(NSIndexPath *)indexPath clickBtn:(UIButton *)sender{
    UIButton * shopCartBtn = (UIButton *)[self.view viewWithTag:1000];
    CGRect startRect = [sender.superview convertRect:sender.frame toView:self.view];
    CGRect endRect = [self.view convertRect:shopCartBtn.frame toView:self.view];
    [self.view addSubview:self.throwImageView];
    __weak typeof(self) weakSelf = self;
    [ShopCartThrowLineTools createSCThrowLineWithObject:self.throwImageView from:startRect.origin to:endRect.origin animationFinishedBlock:^{
        [weakSelf.throwImageView removeFromSuperview];
        [UIView animateWithDuration:.1f animations:^{
            shopCartBtn.transform = CGAffineTransformMakeScale(.8f, .8f);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.1f animations:^{
                shopCartBtn.transform = CGAffineTransformMakeScale(1, 1);
            } completion:^(BOOL finished) {
                
            }];
        }];
    }];
    
    ShopCartGoodsModel * model = self.dataArray[indexPath.section].goodsArray[indexPath.row];
    if (![self.orderArray containsObject:model]) {
         [self.orderArray addObject:model]; //如果当前不存在某个商品 就添加
        for (ShopCartGoodsModel * model in self.orderArray) {
            NSLog(@"name--%@",model.goodsName);
        }
    }
    [self.rightTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    self.bottomView.badgeValue++;
    self.bottomView.orderDataArray = self.orderArray;
}

-(void)subtractnBtnClickd:(NSIndexPath *)indexPath clickBtn:(UIButton *)sender{
    //将商品从购物车中移除
    ShopCartGoodsModel * model = self.dataArray[indexPath.section].goodsArray[indexPath.row];
    if (model.orderCount == 0) {
        //处理当前订单数组里面都是一种模型的情况 只有当订单数量为0 再移除数组
        [self.orderArray removeObject:model];
    }
    [self.rightTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    self.bottomView.badgeValue--;
    self.bottomView.orderDataArray = self.orderArray;
}

#pragma mark --- 移除所有监听
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NotificationRemoveAll(self);
}

@end
