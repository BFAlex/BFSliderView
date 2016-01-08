//
//  BFSliderView.h
//  BFViewFactory
//
//  Created by Readboy_BFAlex on 16/1/7.
//  Copyright © 2016年 Readboy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BFSliderViewDelegate <NSObject>

- (void)sliderValueHaveChanged:(NSInteger)newValue;

@end

@interface BFSliderView : UIView

@property (nonatomic, assign) id<BFSliderViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UISlider *sliderView;
@property (weak, nonatomic) IBOutlet UILabel *showMinValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *showMaxValueLabel;


+ (id)sliderViewWithFrame:(CGRect)frame andMinValue:(CGFloat)minValue maxValue:(CGFloat)maxValue;

- (void)changeSliderMinValue:(CGFloat)minValue andMaxValue:(CGFloat)maxValue;

@end
