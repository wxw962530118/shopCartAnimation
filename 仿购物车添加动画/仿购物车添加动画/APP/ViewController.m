//
//  ViewController.m
//  仿购物车添加动画
//
//  Created by 王新伟 on 2017/6/21.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "ViewController.h"
#import "ShopCartViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)goShopping:(id)sender {
    ShopCartViewController * vc = [[ShopCartViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
