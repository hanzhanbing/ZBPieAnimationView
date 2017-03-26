//
//  ZBPieView.h
//  ZBPieAnimationView
//
//  Created by zhanbing han on 17/3/26.
//  Copyright © 2017年 cydf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZBPieView : UIView

-(instancetype)initWithFrame:(CGRect)frame andPercent:(float)percent andColor:(UIColor *)color;

-(void)reloadViewWithPercent:(float)percent;

@end
