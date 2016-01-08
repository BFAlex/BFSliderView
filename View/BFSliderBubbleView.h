//
//  BFSliderBubbleView.h
//  BFViewFactory
//
//  Created by Readboy_BFAlex on 16/1/7.
//  Copyright © 2016年 Readboy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFSliderBubbleView : UIView

@property (weak, nonatomic) IBOutlet UILabel *numLabel;

+ (instancetype)sliderBubbleViewWithFrame:(CGRect)frame;

@end
