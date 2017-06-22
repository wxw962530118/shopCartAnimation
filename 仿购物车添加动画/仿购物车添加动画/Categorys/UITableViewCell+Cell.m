//
//  UITableViewCell+Cell.m
//  仿购物车添加动画
//
//  Created by 王新伟 on 2017/6/21.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "UITableViewCell+Cell.h"

@implementation UITableViewCell (Cell)

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kTCCellIdentifier];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTCCellIdentifier];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadWithComponents];
    }
    return cell;
}

/**
 *  tableViewCell 布局cell
 */
- (void)loadWithComponents{
    
}

+ (instancetype)cellWithTableViewFromXIB:(UITableView *)tableView{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kTCCellIdentifier];
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil) {
        cell = [self viewFromXIB];
    }
    return cell;
}

/**
 *  自动从xib创建视图
 */
+(instancetype)viewFromXIB {
    UITableViewCell * xibCell = [[[NSBundle mainBundle] loadNibNamed:kTCCellIdentifier owner:nil options:nil] firstObject];
    if (xibCell == nil) {
        NSLog(@"CoreXibView：从xib创建视图失败，当前类是：%@", kTCCellIdentifier);
    }
    return xibCell;
}

- (void)setDataWithModel:(NSObject *)model{
    
}

+ (CGFloat)getCellHeightWithModel:(NSObject *)model{
    return 0;
}

@end
