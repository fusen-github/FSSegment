//
//  FSChildViewController.m
//  FSSegment2
//
//  Created by 四维图新 on 15/12/13.
//  Copyright © 2015年 四维图新. All rights reserved.
//

#import "FSChildViewController.h"

@interface FSChildViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *requestData;

@property (nonatomic, weak) UIRefreshControl *refresh;

@end

@implementation FSChildViewController



- (NSMutableArray *)requestData
{
    if (_requestData == nil)
    {
        _requestData = [NSMutableArray array];
    }
    
    return _requestData;
}

- (instancetype)initWithSegmentIndex:(NSInteger)segmentIdx titleButtonIndex:(NSInteger)titleIdx
{
    if (self = [super init])
    {
        self.view.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.tableView = tableView;
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    
    [refresh addTarget:self
                action:@selector(refreshNewData)
      forControlEvents:UIControlEventValueChanged];
    
    self.refresh = refresh;
    
    refresh.center = CGPointMake(self.view.bounds.size.width * 0.5, 64);
    
    [self.tableView addSubview:refresh];
}

- (void)refreshNewData
{
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    NSLog(@"没有数据");
    
    [self.refresh endRefreshing];
    
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    
}

- (void)setStr:(NSString *)str
{
    _str = str;
    
    [self.refresh beginRefreshing];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [NSThread sleepForTimeInterval:1.5];
        
        for (int i = 0; i < 20; i++)
        {
            [self.requestData addObject:[NSString stringWithFormat:@"%@ -- %d",str,i]];
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            
            [self.refresh endRefreshing];
        });
        
    });
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.requestData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@item的第%ld行数据",self.requestData[indexPath.row],indexPath.row];
    
    return cell;
}






@end





