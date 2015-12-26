//
//  ViewController.m
//  FSSegment2
//
//  Created by 四维图新 on 15/12/13.
//  Copyright © 2015年 四维图新. All rights reserved.
//

#import "ViewController.h"
#import "FSTabTitleBar.h"
#import "FSChildViewController.h"

@interface ViewController ()<FSTabTitleBarDelegate>

@property (nonatomic, weak) FSTabTitleBar *firstTabBar;

@property (nonatomic, weak) FSTabTitleBar *secondTabBar;

@property (nonatomic, strong) NSArray *firstTitleArr;

@property (nonatomic, strong) NSArray *secconTitleArr;

@property (nonatomic, strong) NSMutableArray *firstControllers;

@property (nonatomic, strong) NSMutableArray *secondControllers;

@property (nonatomic, strong) FSChildViewController *currentVC;

@property (nonatomic, assign) CGRect tabBarFrame;

@property (nonatomic, weak) UISegmentedControl *segment;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation ViewController

- (NSMutableArray *)dataArr
{
    if (_dataArr == nil)
    {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (NSMutableArray *)firstControllers
{
    if (_firstControllers == nil)
    {
        _firstControllers = [NSMutableArray array];
    }
    return _firstControllers;
}

- (NSMutableArray *)secondControllers
{
    if (_secondControllers == nil)
    {
        _secondControllers = [NSMutableArray array];
    }
    return _secondControllers;
}

- (NSArray *)firstTitleArr
{
    if (_firstTitleArr == nil)
    {
        _firstTitleArr = [NSArray arrayWithObjects:@"A1",@"A2",@"A3",@"A4",@"A5",@"A6",@"A7",@"A8",nil];
    }
    return _firstTitleArr;
}

- (NSArray *)secconTitleArr
{
    if (_secconTitleArr == nil)
    {
        _secconTitleArr = [NSArray arrayWithObjects:@"B1",@"B2",@"B3",@"B4",@"B5",@"B6",@"B7",@"B8", nil];
    }
    return _secconTitleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestData];
    
    [self setupNavBar];
    
    [self setupAllChildViewController];
    
}

- (void)requestData
{
    [self.dataArr addObject:self.firstTitleArr];
    
    [self.dataArr addObject:self.secconTitleArr];
}


- (void)setupNavBar
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"AAA",@"BBB"]];
    
    self.segment = segment;
    
    segment.selectedSegmentIndex = 0;
    
    [segment addTarget:self
                action:@selector(didClickSegment:)
      forControlEvents:UIControlEventValueChanged];
    
    if (segment.selectedSegmentIndex == 0)
    {
        [self didClickSegment:segment];
    }
    
    self.navigationItem.titleView = segment;
}


- (void)didClickSegment:(UISegmentedControl *)segment
{
    CGRect tabFrame = CGRectMake(0, 64, self.view.bounds.size.width, 50);
    
    self.tabBarFrame = tabFrame;
    
    UIColor *bgColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1];
    
    if (segment.selectedSegmentIndex == 0)
    {
        [self.secondTabBar removeFromSuperview];
        
        FSTabTitleBar *firstTabBar = [[FSTabTitleBar alloc] initWithFrame:tabFrame titlesArr:self.firstTitleArr];
        
        self.firstTabBar = firstTabBar;
        
        firstTabBar.delegate = self;
        
        firstTabBar.backgroundColor = bgColor;
        
        [self.view addSubview:firstTabBar];
        
        FSChildViewController *vc = self.firstControllers.firstObject;
        
        NSArray *firstArr = self.dataArr.firstObject;
        
        vc.str = firstArr.firstObject;
        
        [self transitionFromCurrentController:self.currentVC toNextController:vc];
        
    }
    else if (segment.selectedSegmentIndex == 1)
    {
        [self.firstTabBar removeFromSuperview];
        
        FSTabTitleBar *secondTabBar = [[FSTabTitleBar alloc] initWithFrame:tabFrame titlesArr:self.secconTitleArr];
        
        secondTabBar.backgroundColor = bgColor;
        
        secondTabBar.delegate = self;
        
        self.secondTabBar = secondTabBar;
        
        [self.view addSubview:secondTabBar];
        
        FSChildViewController *vc = self.secondControllers.firstObject;
        
        NSArray *secondArr = self.dataArr[1];
        
        vc.str = secondArr[0];
        
        [self transitionFromCurrentController:self.currentVC toNextController:vc];
        
    }
}


- (void)setupAllChildViewController
{
    [self.firstTitleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        FSChildViewController *childVC = [[FSChildViewController alloc] initWithSegmentIndex:0 titleButtonIndex:idx];
        
        [self.firstControllers addObject:childVC];
    
    }];
    
    [self.secconTitleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        FSChildViewController *childVC = [[FSChildViewController alloc] initWithSegmentIndex:1 titleButtonIndex:idx];
        
        [self.secondControllers addObject:childVC];
        
    }];
    
    FSChildViewController *vc = self.firstControllers.firstObject;
    
    NSArray *firstArr = self.dataArr.firstObject;
    
    vc.str = firstArr.firstObject;
    
    [self.view addSubview:vc.view];
    
    [self addChildViewController:vc];
    
    [self transitionFromCurrentController:nil toNextController:vc];
}

- (void)transitionFromCurrentController:(FSChildViewController *)currentVC toNextController:(FSChildViewController *)nextVC;
{
    nextVC.view.frame = CGRectMake(0, CGRectGetMaxY(self.tabBarFrame), self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(self.tabBarFrame) - 64);
    
    if (currentVC)
    {
        [self addChildViewController:nextVC];
        
        [self transitionFromViewController:currentVC toViewController:nextVC duration:0.25f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            
        } completion:^(BOOL finished) {
            
            self.currentVC = nextVC;

        }];
    }else
    {
        self.currentVC = nextVC;
    }
}


- (void)didFinishClickTabBarButtonWithIndex:(NSInteger)index
{
    if (self.segment.selectedSegmentIndex == 0)
    {
        FSChildViewController *nextVC = self.firstControllers[index];
        
        NSArray *firstArr = self.dataArr.firstObject;
        
        nextVC.str = firstArr[index];
        
        [self transitionFromCurrentController:self.currentVC toNextController:nextVC];
        
    }else if (self.segment.selectedSegmentIndex == 1)
    {
        FSChildViewController *nextVC = self.secondControllers[index];
        
        NSArray *secondArr = self.dataArr.lastObject;
        
        nextVC.str = secondArr[index];
        
        [self transitionFromCurrentController:self.currentVC toNextController:nextVC];
    }
}









@end






