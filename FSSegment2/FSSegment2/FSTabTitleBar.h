//
//  FSTabTitleBar.h
//  FSSegment2
//
//  Created by 四维图新 on 15/12/13.
//  Copyright © 2015年 四维图新. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FSTabTitleBarDelegate <NSObject>

- (void)didFinishClickTabBarButtonWithIndex:(NSInteger)index;

@end

@interface FSTabTitleBar : UIView


@property (nonatomic, weak) id<FSTabTitleBarDelegate> delegate;


- (instancetype)initWithFrame:(CGRect)frame titlesArr:(NSArray *)titlesArr;


@end
