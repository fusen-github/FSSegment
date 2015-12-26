//
//  FSChildViewController.h
//  FSSegment2
//
//  Created by 四维图新 on 15/12/13.
//  Copyright © 2015年 四维图新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSChildViewController : UIViewController

/// 请求数据的参数。
@property (nonatomic, strong) NSString *str;

- (instancetype)initWithSegmentIndex:(NSInteger)segmentIdx titleButtonIndex:(NSInteger)titleIdx;


@end
