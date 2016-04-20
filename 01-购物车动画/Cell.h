//
//  Cell.h
//  01-购物车动画
//
//  Created by vera on 16/4/7.
//  Copyright © 2016年 vera. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShoppingCarButtonDidClickHandle)(CGPoint centerPoint);

@interface Cell : UITableViewCell

//设置添加购物车回调
- (void)setShoppingCarButtonDidClickHandle:(ShoppingCarButtonDidClickHandle)handle;

@end
