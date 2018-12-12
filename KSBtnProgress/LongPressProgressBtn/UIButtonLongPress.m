//
//  UIButtonLongPress.m
//  KSBtnProgress
//
//  Created by Kris on 2018/12/11.
//  Copyright © 2018年 Kris. All rights reserved.
//

#import "UIButtonLongPress.h"

static const double defaultDuration = 1.0;
static NSString * const kProgressAnimation = @"kProgressAnimation";

@interface UIButtonLongPress ()<CAAnimationDelegate>

@property (nonatomic, strong)CAShapeLayer *shapeLayer;

@end

@implementation UIButtonLongPress


// MARK: - LifeCycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        _longPressDuration = defaultDuration;
        
        [self addTarget:self action:@selector(touchDownHandler:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(touchUpHandler:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.layer addSublayer:self.shapeLayer];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _longPressDuration = defaultDuration;
        
        [self addTarget:self action:@selector(touchDownHandler:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(touchUpHandler:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.layer addSublayer:self.shapeLayer];
    }
    return self;
}

// MARK: - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (anim == [self.shapeLayer animationForKey:kProgressAnimation] && flag) {
        if (self.completeBlock) {
            self.completeBlock();
        }
    }
}

// MARK: - Handler
- (void)touchDownHandler:(UIButton *)btn
{
    [self startAnimation];
}

- (void)touchUpHandler:(UIButton *)btn
{
    [self resetAnimation];
}

// MARK: - Util-Animation
- (void)startAnimation
{
    // 贝塞尔曲线
    CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGFloat radius = self.frame.size.width/2;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:center
                                                              radius:radius
                                                          startAngle:-M_PI_2
                                                            endAngle:-M_PI_2+M_PI*2
                                                           clockwise:YES];
    
    // 动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0.0);
    animation.toValue = @(1.0);
    animation.duration = _longPressDuration;
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    
    // SharpLayer
    self.shapeLayer.path = bezierPath.CGPath;
    [self.shapeLayer addAnimation:animation forKey:kProgressAnimation];
}

- (void)resetAnimation
{
    [self.shapeLayer removeAnimationForKey:kProgressAnimation];
    CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGFloat radius = self.frame.size.width/2;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:center
                                                              radius:radius
                                                          startAngle:-M_PI_2
                                                            endAngle:-M_PI_2
                                                           clockwise:YES];
    self.shapeLayer.path = bezierPath.CGPath;
}

// MARK: - Get & Set
- (void)setLongPressDuration:(double)longPressDuration
{
    _longPressDuration = longPressDuration;
}

- (CAShapeLayer *)shapeLayer
{
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.fillColor   = [UIColor clearColor].CGColor;//填充色
        _shapeLayer.strokeColor = [UIColor redColor].CGColor;//边框色
        _shapeLayer.lineWidth = 4;//线宽
        _shapeLayer.lineCap = kCALineCapButt;//线头无形状
    }
    return _shapeLayer;
}

@end
