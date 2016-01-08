//
//  BFSliderViewTestController.m
//  BFViewFactory
//
//  Created by Readboy_BFAlex on 16/1/7.
//  Copyright © 2016年 Readboy. All rights reserved.
//

#import "BFSliderViewTestController.h"
#import "BFSliderView.h"

@interface BFSliderViewTestController () <BFSliderViewDelegate> {
    
    BFSliderView *_slider;
}

@end

@implementation BFSliderViewTestController

#pragma mark - initialize
- (UIView *)getSliderView {
    
    CGRect sliderBounds = CGRectMake(0, 0, self.view.bounds.size.width - 20, 60);
    
    BFSliderView *slider = [BFSliderView sliderViewWithFrame:sliderBounds andMinValue:1 maxValue:1000];
    
    slider.center = self.view.center;
    
    return slider;
}

- (void)sliderValueHaveChanged:(NSInteger)newValue {
    NSLog(@"%s\n %zd", __func__, newValue);
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:204/255.0 green:239/255.0 blue:209/255.0 alpha:1.0];
    
    _slider = (BFSliderView *)[self getSliderView];
    _slider.delegate = self;
    [self.view addSubview:_slider];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    CGPoint center = self.view.center;
    center.y = _slider.frame.origin.y + _slider.bounds.size.height * 2;
    btn.center = center;
    [btn setBackgroundColor:[UIColor yellowColor]];
    [btn setTitle:@"点我" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)clickBtn:(UIButton *)btn {
    NSLog(@"%s", __func__);
    
    CGFloat minValue = arc4random() % 100 +1;
    CGFloat maxValue = arc4random() % 10000 + minValue;
    [_slider changeSliderMinValue:minValue andMaxValue:maxValue];
}

@end
