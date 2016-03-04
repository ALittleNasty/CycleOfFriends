//
//  ViewController.m
//  CycleOfFriends
//
//  Created by 胡阳 on 15/12/21.
//  Copyright © 2015年 young4ever. All rights reserved.
//

#import "ViewController.h"
#import "PopFunctionView.h"

static NSString *cellIndetifier = @"chatCellID";

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate , PopFunctionViewDelegate>
    
@property (weak, nonatomic) IBOutlet UITableView *tableView ;

@property (nonatomic, strong) PopFunctionView    *popView ;

@property (nonatomic, assign) int                index ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILongPressGestureRecognizer *pressGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureAction:)];
    pressGes.minimumPressDuration = 1.0 ;
    [self.tableView addGestureRecognizer:pressGes];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIndetifier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20 ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"这是测试数据第%ld条",indexPath.row];
    
    return  cell ;
}

- (void)longPressGestureAction:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        CGPoint point_tableView = [gesture locationInView:self.tableView];
        
        CGPoint point_selfView = [gesture locationInView:self.view];
        
        NSLog(@"point --- %@",NSStringFromCGPoint(point_tableView));
        
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point_tableView];
        
        if (indexPath == nil) return ;
        
        NSLog(@"这是第%ld条cell",indexPath.row);
        
        _popView = [[PopFunctionView alloc] initWithFrame:CGRectZero position:point_selfView type:PopFunctionViewTypeCopyAndDelete delegate:self];
        [_popView show];
    }
}

- (void)copyButtonClickedOnPopFunctionView:(PopFunctionView *)functionView
{
    NSLog(@"----- %s ======",__func__);
}
- (void)deleteButtonClickedOnPopFunctionView:(PopFunctionView *)functionView
{
    NSLog(@"----- %s ======",__func__);
}

@end
