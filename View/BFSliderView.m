//
//  BFSliderView.m
//  BFViewFactory
//
//  Created by Readboy_BFAlex on 16/1/7.
//  Copyright © 2016年 Readboy. All rights reserved.
//

#import "BFSliderView.h"
#import "BFSliderBubbleView.h"

#define kBubbleWH   80
#define kBubbleAnimationTime    5.0f

#define kBubbleMarge    31.0f   // 用来调整气泡相对于slider滑点的位置差，值为滑点的直径(slider的height)

@interface BFSliderView () {
    
    BFSliderBubbleView *_bubble;
    
    CGFloat _minValue;
    CGFloat _maxValue;
    
    CGFloat _percentage;
}

@end

@implementation BFSliderView

+ (id)sliderViewWithFrame:(CGRect)frame andMinValue:(CGFloat)minValue maxValue:(CGFloat)maxValue {
    
    BFSliderView *slider = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    
    if (slider && minValue <= maxValue) {
        
        [UIView animateWithDuration:0.01f animations:^{
        
            slider.frame = frame;
            
//            [slider setupMinValue:minValue andMaxValue:maxValue];
            [slider changeSliderMinValue:minValue andMaxValue:maxValue];
            
        } completion:^(BOOL finished) {
            
            slider.sliderView.minimumValue = slider.sliderView.frame.origin.x;
            slider.sliderView.maximumValue = slider.sliderView.frame.origin.x + slider.sliderView.bounds.size.width;
            
            [slider.sliderView addTarget:slider action:@selector(touchDownSlider:) forControlEvents:UIControlEventTouchDown];
            [slider.sliderView addTarget:slider action:@selector(touchUpSlider:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
            [slider.sliderView addTarget:slider action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
            
            [slider calculatePercentage];
        }];
    }
    
    return slider;
}

//- (void)setupMinValue:(CGFloat)minValue andMaxValue:(CGFloat)maxValue {
//    
//    _minValue = minValue;
//    
//    _maxValue = maxValue;
//}

- (void)calculatePercentage {
    
//    if (_maxValue == 1000) {
    
         _percentage = (_maxValue - _minValue + 1) / self.sliderView.bounds.size.width;
        
//    } else {
//        
//        _percentage = (_maxValue - _minValue) / self.sliderView.bounds.size.width;
//    }    
}

- (CGPoint)calculateBubbleCenter {
    
    CGFloat x = self.sliderView.value;
    
//    CGPoint center = CGPointMake(x, self.sliderView.frame.origin.y - kBubbleWH/2);
    CGPoint center = CGPointMake(x - kBubbleMarge * ((_sliderView.value - _sliderView.frame.origin.x) / _sliderView.bounds.size.width) + kBubbleMarge/2, self.sliderView.frame.origin.y - kBubbleWH/2);
    
    
    return center;
}

- (void)changeSliderMinValue:(CGFloat)minValue andMaxValue:(CGFloat)maxValue {
    
    if (minValue > maxValue) {
        
        UIAlertView *alier = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"重新设置的值不符合要求，请重新设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alier show];
        
    } else {
        
        _minValue = minValue;
        _maxValue = maxValue;
        
        [self calculatePercentage];
        
        self.showMinValueLabel.text = [NSString stringWithFormat:@"%d米", (int)_minValue];
        self.showMaxValueLabel.text = [NSString stringWithFormat:@"%d米", (int)_maxValue];
    }
}

#pragma mark - sliderView action
- (void)touchDownSlider:(UISlider *)slider {
    NSLog(@"%s\n\n", __func__);
    
    _bubble = [BFSliderBubbleView sliderBubbleViewWithFrame:CGRectMake(0, 0, kBubbleWH, kBubbleWH)];
    _bubble.center = [self calculateBubbleCenter];
    
    [self addSubview:_bubble];
}

- (void)touchUpSlider:(UISlider *)slider {
    NSLog(@"%s\n\n", __func__);
    
    if (_bubble) {
        
        [UIView animateWithDuration:kBubbleAnimationTime animations:^{
            
        } completion:^(BOOL finished) {
            
            [_bubble removeFromSuperview];
            
            _bubble = nil;
        }];
    }
}

- (void)valueChanged:(UISlider *)slider {
    NSLog(@"%s %f\n\n", __func__, slider.value);
    
    if (_bubble) {
        
        _bubble.center = [self calculateBubbleCenter];
        
        NSInteger num = (slider.value - slider.frame.origin.x) * _percentage + _minValue;
        
        if (num > _maxValue) {
            
            num = _maxValue;
        }
        
        _bubble.numLabel.text = [NSString stringWithFormat:@"%zd", num];
        
        if ([self.delegate respondsToSelector:@selector(sliderValueHaveChanged:)]) {
            
            [self.delegate sliderValueHaveChanged:num];
        }
    }
}


- (NSString *)description {
    
    NSString *str = [super description];
    
    NSString *desc = [NSString stringWithFormat:@"%@\n\n slider: %@", str, self.sliderView];
    
    return desc;
}

@end
