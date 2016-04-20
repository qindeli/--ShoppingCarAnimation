//
//  ViewController.m
//  01-购物车动画
//
//  Created by vera on 16/4/7.
//  Copyright © 2016年 vera. All rights reserved.
//

#import "ViewController.h"
#import "Cell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    /**
     *  动画的终点
     */
    CGPoint _endPoint;
}

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation ViewController

- (UITableView *)tableView
{
    if (!_tableView)
    {
        UITableView *tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        tb.delegate = self;
        tb.dataSource = self;
        tb.rowHeight = 80;
        [self.view addSubview:tb];
        
        [tb registerNib:[UINib nibWithNibName:@"Cell" bundle:nil] forCellReuseIdentifier:@"Cell"];
        
        _tableView = tb;
    }
    
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self tableView];
    [self createShoppingCarButton];
}

/**
 *  创建购物车按钮
 */
- (void)createShoppingCarButton
{
    //按钮宽度和高度
    CGFloat buttonWidth = 60;
    CGFloat buttonHeight = buttonWidth;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, self.view.frame.size.height - 20 - buttonHeight, buttonWidth, buttonHeight);
    [btn setBackgroundImage:[UIImage imageNamed:@"car"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    _endPoint = btn.center;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    [cell setShoppingCarButtonDidClickHandle:^(CGPoint centerPoint) {
        
        //起点
        CGPoint startPoint = centerPoint;
        //控点
        CGPoint controlPoint = CGPointMake(_endPoint.x, startPoint.y);
        
        //创建一个layer
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, 40, 40);
        layer.position = centerPoint;
        layer.backgroundColor = [UIColor redColor].CGColor;
        layer.cornerRadius = layer.frame.size.width/2;
        layer.masksToBounds = YES;
        [self.view.layer addSublayer:layer];
        
        //创建关键帧
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        animation.delegate = self;
        //动画时间
        animation.duration = 5;
        
        //当动画完成，停留到结束位置
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        
        //当方法名字遇到create,new,copy,retain，都需要管理内存
        CGMutablePathRef path = CGPathCreateMutable();
        //设置起点
        CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
        CGPathAddQuadCurveToPoint(path, NULL, controlPoint.x, controlPoint.y, _endPoint.x, _endPoint.y);
        
        //设置动画路径
        animation.path = path;
        
        //执行动画
        [layer addAnimation:animation forKey:nil];
        
        //释放路径
        CGPathRelease(path);
    }];
    
    return cell;
}

/**
 *  动画完成会触发
 *
 *  @param anim <#anim description#>
 */
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"动画完成了");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
