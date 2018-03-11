//
//  ZXLSegmentView.h
//  GDPR
//
//  Created by zxl on 2017/12/26.
//  Copyright © 2017年 EM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXLSegmentView : UIView
// 标题
@property (nonatomic, copy) void (^clickSegmentButton)(NSInteger index);
@property (nonatomic, strong)UIView *canSliderLine; /**<底部可滑动的线*/

- (instancetype)initWithSegmentWithTitleArray:(NSArray *)segementTitleArray;

//滑动到当前选中的segment
- (void)movieToCurrentSelectedSegment:(NSInteger)index;

@end
