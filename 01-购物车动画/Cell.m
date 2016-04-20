//
//  Cell.m
//  01-购物车动画
//
//  Created by vera on 16/4/7.
//  Copyright © 2016年 vera. All rights reserved.
//

#import "Cell.h"

@interface Cell ()
{
    ShoppingCarButtonDidClickHandle _shoppingCarButtonDidClickHandle;
}

@end

@implementation Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setShoppingCarButtonDidClickHandle:(ShoppingCarButtonDidClickHandle)handle
{
    _shoppingCarButtonDidClickHandle = handle;
}

/**
 *  添加购物车
 *
 *  @param sender <#sender description#>
 */
- (IBAction)shoppingCarButtonClick:(UIButton *)sender
{
    CGPoint carButtonCenter = sender.center;
    
    //把button在cell坐标转化为在tableView上的坐标
    CGPoint point = [self convertPoint:carButtonCenter toView:self.superview];
    
    //回调
    if (_shoppingCarButtonDidClickHandle)
    {
        _shoppingCarButtonDidClickHandle(point);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
