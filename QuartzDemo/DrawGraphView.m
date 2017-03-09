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
    //获取当前的context
    CGContextRef context = UIGraphicsGetCurrentContext();  //我们直接用context是因为系统发现需要更新视图时，自动给我们创建好context画板，他就是视图本身
    CGContextSaveGState(context);
    
    //线宽
    CGContextSetLineWidth(context, 2.0f);
    //线颜色
    CGContextSetStrokeColorWithColor(context, _color.CGColor);
    //switch选择画图
    switch (self.type) {
        case kLineGraph:
            //直线
            CGContextMoveToPoint(context, pntBegin.x, pntBegin.y); //起点
            CGContextAddLineToPoint(context, pntEnd.x, pntEnd.y);  //划线到终点
            CGContextStrokePath(context);  //开始画
            break;
        case kRectGraph:
            CGContextSetFillColorWithColor(context, _color.CGColor);
            CGContextAddRect(context, [self selectedArea]);
            CGContextDrawPath(context, kCGPathFillStroke);
            break;
            
        case kRoundGraph:
            CGContextSetFillColorWithColor(context, _color.CGColor);
            CGContextAddEllipseInRect(context, [self selectedArea]);
            CGContextDrawPath(context, kCGPathFillStroke);
            break;
        default:
            break;
    }
    CGContextRestoreGState(context);
}

- (CGRect) selectedArea {
    CGPoint pntS = CGPointZero;
    pntS.x = (pntBegin.x > pntEnd.x) ? pntEnd.x : pntBegin.x;
    pntS.y = (pntBegin.y > pntEnd.y) ? pntEnd.y : pntBegin.y;
    
    return CGRectMake(pntS.x,
                      pntS.y,
                      fabs(pntEnd.x-pntBegin.x),
                      fabs(pntEnd.y-pntBegin.y)); //fabs()是绝对值
}



//由于view也是继承自UIResponder,所以可以直接用touch
//MARKE:
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    pntBegin = [touch locationInView:self];
    pntEnd = [touch locationInView:self];
    
    [self setNeedsDisplay]; //使用这个函数会更新这个view,所以上一次画的会消失
    
    //[self setNeedsDisplayInRect:[self selectedArea]];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    pntEnd = [touch locationInView:self];
    
    [self setNeedsDisplay];
     //[self setNeedsDisplayInRect:[self selectedArea]];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    pntEnd = [touch locationInView:self];
    
    [self setNeedsDisplay];
     //[self setNeedsDisplayInRect:[self selectedArea]];
}

@end
