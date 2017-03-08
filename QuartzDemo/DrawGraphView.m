//
//  DrawGraphView.m
//  QuartzDemo
//
//  Created by naton on 2017/3/8.
//  Copyright © 2017年 com.naton.haibo. All rights reserved.
//

#import "DrawGraphView.h"

@implementation DrawGraphView
{
    CGPoint pntBegin;
    CGPoint pntEnd;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
    }
    return self;
}

//对于所有的view的子类，都有一个drawRect待开发者重写。drawRect是系统在某个时机进行调用，作用就是对当前的视图进行更新
//所以绘画的所有代码，我们都要写到drawRect里面
//drawRect的调用：在视图第一次出现的时候会全视图范围地调用一次，之后的调用和开发者的指令有关，只要开发者对视图对象进行一次setNeedsDisplay或者setNeedsDisplayInRect的话，试图对象就知道要刷新自己了。等到当前消息循环一圈跑完后，系统会检查所有视图对象的needsDisplay标志位，如果为YES的话会调用视图的drawRect方法。
//setNeedsDisplay和setNeedsDisplayInRect的区别，前者刷新整个视图，后者刷新指定区域视图，此区域会以参数的形式传递给drawRect
- (void)drawRect:(CGRect)rect {
    
}

@end
