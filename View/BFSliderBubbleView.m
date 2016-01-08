//
//  BFSliderBubbleView.m
//  BFViewFactory
//
//  Created by Readboy_BFAlex on 16/1/7.
//  Copyright © 2016年 Readboy. All rights reserved.
//

#import "BFSliderBubbleView.h"

@implementation BFSliderBubbleView

+ (instancetype)sliderBubbleViewWithFrame:(CGRect)frame {
    
    BFSliderBubbleView *bubble = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    
    if (bubble) {
        
        bubble.frame = frame;
        
//        bubble.numLabel.font = [UIFont systemFontOfSize:bubble.bounds.size.width * 0.333];
        bubble.numLabel.font = [UIFont systemFontOfSize:bubble.bounds.size.width * 0.3];
    }
    
    return bubble;
}

@end
