//
//  ZBPieView.m
//  ZBPieAnimationView
//
//  Created by zhanbing han on 17/3/26.
//  Copyright © 2017年 cydf. All rights reserved.
//

#import "ZBPieView.h"
#import "UILabel+PPCounter.h"

#define LINE_WIDTH 10//环形宽度
#define DURATION 1.0//动画时间
#define TEXT_FONT 8.f

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ZBPieView()

@property (nonatomic,assign) float      percent;
@property (nonatomic,assign) float      radius;
@property (nonatomic,assign) CGPoint    centerPoint;
@property (nonatomic,strong) UIColor    *lineColor;

@property (nonatomic,strong) CAShapeLayer *lineLayer;
@property (nonatomic,strong) UILabel      *textLab;

@end

@implementation ZBPieView

-(instancetype)initWithFrame:(CGRect)frame andPercent:(float)percent andColor:(UIColor *)color{
    if(self = [super initWithFrame:frame]) {
        self.percent = percent;
        self.radius = CGRectGetWidth(frame) / 2.0 - LINE_WIDTH / 2.0;
        self.lineColor = color;
        self.centerPoint = CGPointMake(CGRectGetWidth(frame) / 2.0, CGRectGetWidth(frame) / 2.0);
        [self createBackLine];
        [self commonInit];
    }
    return self;
}

-(void)setPercent:(float)percent {
    if (percent >= 1) {
        _percent = 1;
    }else {
        _percent = percent;
    }
}

-(void)reloadViewWithPercent:(float)percent {
    self.percent = percent;
    [self.layer removeAllAnimations];
    [self.lineLayer removeFromSuperlayer];
    [self.textLab removeFromSuperview];
    [self commonInit];
}

-(void)commonInit {
    [self createPercentLayer];
    [self setPercentTextLab];
}

-(void)createBackLine {
    //绘制背景
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = 7;
    shapeLayer.strokeColor = [UIColorFromRGB(0xF2F2F2) CGColor];
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    UIBezierPath *path = [UIBezierPath new];
    [path addArcWithCenter:self.centerPoint radius:self.radius startAngle:-M_PI / 2.0 endAngle:M_PI / 2 * 3 clockwise:YES];
    shapeLayer.path = path.CGPath;
    [self.layer addSublayer:shapeLayer];
}

-(void)createPercentLayer {
    //绘制环形
    self.lineLayer = [CAShapeLayer layer];
    self.lineLayer.lineWidth = 13;
    self.lineLayer.lineCap = kCALineCapRound;
    self.lineLayer.strokeColor = [UIColorFromRGB(0x25D880) CGColor];
    self.lineLayer.fillColor = [[UIColor clearColor] CGColor];
    
    self.lineLayer.shadowOffset =  CGSizeMake(0, 2); //阴影偏移量
    self.lineLayer.shadowOpacity = 0.5; //透明度
    self.lineLayer.shadowColor =  UIColorFromRGB(0x1BFF93).CGColor; //阴影颜色
    self.lineLayer.shadowRadius = 10; //模糊度
    
    UIBezierPath *path = [UIBezierPath new];
    [path addArcWithCenter:self.centerPoint radius:self.radius startAngle:-M_PI / 2.0 endAngle:M_PI * 2 * self.percent - M_PI / 2.0 clockwise:NO];
    self.lineLayer.path = path.CGPath;
    CABasicAnimation *showAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    showAnimation.fromValue = @0;
    showAnimation.toValue = @1;
    showAnimation.duration = DURATION;
    showAnimation.removedOnCompletion = YES;
    showAnimation.fillMode = kCAFillModeForwards;
    [self.layer addSublayer:self.lineLayer];
    [self.lineLayer addAnimation:showAnimation forKey:@"kClockAnimation"];
}

-(void)setPercentTextLab {
    self.textLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    // 开始计数
    [self.textLab pp_fromNumber:0 toNumber:(1-self.percent) * 100 duration:1.0f format:^NSString *(CGFloat number) {
        NSNumberFormatter *formatter = [NSNumberFormatter new];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        formatter.positiveFormat = @"###,##0";
        NSNumber *amountNumber = [NSNumber numberWithFloat:number];
        return [NSString stringWithFormat:@"%@%@",[formatter stringFromNumber:amountNumber],@"%"];
    }];
    self.textLab.font = [UIFont systemFontOfSize:18];
    self.textLab.textAlignment = NSTextAlignmentCenter;
    self.textLab.textColor = UIColorFromRGB(0x25D880);
    [self addSubview:self.textLab];
}

@end
