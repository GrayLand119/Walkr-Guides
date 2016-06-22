//
//  WGTestView.m
//  Walkr Guides
//
//  Created by GrayLand on 16/4/19.
//  Copyright © 2016年 GrayLand. All rights reserved.
//

#import "WGTestView.h"

@implementation WGTestView


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(50, 50)];
    [path addLineToPoint:CGPointMake(0, 50)];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor   = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.path        = path.CGPath;
    
    [self.layer addSublayer:layer];
}
@end
