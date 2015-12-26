//
//  FSTabTitleBar.m
//  FSSegment2
//
//  Created by 四维图新 on 15/12/13.
//  Copyright © 2015年 四维图新. All rights reserved.
//

#import "FSTabTitleBar.h"

@interface FSTabTitleBar ()

@property (nonatomic, weak) UIButton *lastButton;

@property (nonatomic, weak) UIView *underLine ;

@end

@implementation FSTabTitleBar


- (instancetype)initWithFrame:(CGRect)frame titlesArr:(NSArray *)titlesArr
{
    if (self = [super initWithFrame:frame])
    {
        [self setupTabBarWithTitles:titlesArr];
    }
    return self;
}


- (void)setupTabBarWithTitles:(NSArray *)titlesArr
{
    CGFloat btnX = 0;
    
    CGFloat btnY = 0;
    
    CGFloat btnW = self.bounds.size.width / titlesArr.count;
    
    CGFloat btnH = self.bounds.size.height;
    
    for (int i = 0; i < titlesArr.count; i++)
    {
        UIButton *button = [[UIButton alloc] init];
        
        button.tag = i;
        
        [button setTitle:titlesArr[i] forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        btnX = btnW * i;
        
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        [button addTarget:self
                   action:@selector(didTouchDownButton:)
         forControlEvents:UIControlEventTouchDown];
        
        [self addSubview:button];
        
        if (i == 0)
        {
            self.lastButton = button;
            
            [self didTouchDownButton:button];
        }
    }
    
    
    UIView *underLine = [[UIView alloc] init];
    
    self.underLine = underLine;
    
    underLine.frame = CGRectMake(0, self.bounds.size.height - 1, self.lastButton.bounds.size.width, 1);
    
    underLine.backgroundColor = [UIColor redColor];
    
    [self addSubview:underLine];
    
}

- (void)didTouchDownButton:(UIButton *)button
{
    self.lastButton.selected = NO;
    
    button.selected = YES;
    
    self.lastButton = button;
    
    if ([self.delegate respondsToSelector:@selector(didFinishClickTabBarButtonWithIndex:)])
    {
        [self.delegate didFinishClickTabBarButtonWithIndex:button.tag];
    }
    
    [UIView animateWithDuration:0.25f animations:^{
       
        self.underLine.frame = CGRectMake(button.tag * self.lastButton.bounds.size.width, self.bounds.size.height - 1, self.lastButton.bounds.size.width, 1);
    }];
    
}




@end


