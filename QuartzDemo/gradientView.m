//
//  gradientView.m
//  QuartzDemo
//
//  Created by NATON on 2017/3/9.
//  Copyright © 2017年 com.naton.haibo. All rights reserved.
//

#import "gradientView.h"

@implementation gradientView

-(void)drawRect:(CGRect)rect {
    [self updateDB:UIGraphicsGetCurrentContext()];
}

- (void)updateDB:(CGContextRef) context {
    //两个颜色，每个颜色分别是红绿蓝alpha四个通道
    CGFloat colors[] = {
        1.0, 1.0, 1.0, 1.0,
        0.4, 0.4, 0.4, 1.0
    };
    
    //创建CGGradientRef对象
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace,
                                                                 colors,
                                                                 NULL,
                                                                 2);
    CGColorSpaceRelease(baseSpace);
    baseSpace = NULL;
    
    //以x轴中间点为主轴，y轴为渐变进行渐变
    CGPoint startPoint = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame));
    CGPoint endPoint = CGPointMake(CGRectGetMinX(self.frame), CGRectGetMaxY(self.frame));
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient);
    gradient = NULL;
}


@end
