//
//  DrawFreeViewController.m
//  QuartzDemo
//
//  Created by naton on 2017/3/8.
//  Copyright © 2017年 com.naton.haibo. All rights reserved.
//

#import "DrawFreeViewController.h"

static NSInteger _rubberWidth = 4.0f;

@interface DrawFreeViewController ()
{
    CGFloat _fRed;
    CGFloat _fGreen;
    CGFloat _fBlue;
    BOOL _bRubber;
    CGPoint _pntBegin; //坐标变量
    BOOL _bMove; //是否手指移动
}

@property (weak, nonatomic) IBOutlet UIImageView *freeCanvas;
@property (weak, nonatomic) IBOutlet UISegmentedControl *colorSegmentControl;

@end

@implementation DrawFreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self actSelectColor:_colorSegmentControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actSelectColor:(id)sender {
    
    UISegmentedControl *control = sender;
    NSInteger index = control.selectedSegmentIndex;
    
    switch (index) {
        case 0:
            _bRubber = NO;
            _fRed = 102.0/255.0f;
            _fGreen = 208.0/255.0f;
            _fBlue = 0.0f/255.0f;
            break;
        case 1:
            _bRubber = NO;
            _fRed = 255.0/255.0f;
            _fGreen = 104.0/255.0f;
            _fBlue = 0.0f/255.0f;
            break;
        case 2:
            _bRubber = YES;
            break;
        default:
            _bRubber = NO;
            break;
    }
}


// MARK: UIControl 的touch事件
// TODO:
// FIXME:
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    _pntBegin      = [touch locationInView:self.view];  //获取手指接触屏幕的坐标值
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    CGContextRef context = NULL;  //我们在Quartz中绘画时，需要一个context来承载绘画的内容，可以将context理解为Quartz中的画板。所以需要首先创建这个画板
    
    //创建context
    UIGraphicsBeginImageContext(self.freeCanvas.frame.size);
    //继续上一次的绘画
    [self.freeCanvas.image drawInRect:self.freeCanvas.frame];
    
    //获取context进行配置
    context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);  //将保存的数据重新读取到画板上
    
    //橡皮擦
    if (_bRubber) {
        //这一步是将橡皮差做成画笔宽度的两倍来用的
        CGContextClearRect(context,
                           CGRectMake(currentPoint.x-_rubberWidth,
                                      currentPoint.y-_rubberWidth,
                                      _rubberWidth * 10,
                                      _rubberWidth * 10));
    } else {
        CGContextMoveToPoint(context, _pntBegin.x, _pntBegin.y);            //移动到起始点上
        CGContextAddLineToPoint(context, currentPoint.x, currentPoint.y);   //增加一段路径到currentPoint
        CGContextSetLineCap(context, kCGLineCapRound);                      //设置直线两端的风格为原型风格
        CGContextSetLineWidth(context, _rubberWidth);   //设置直线的宽度
        CGContextSetBlendMode(context, kCGBlendModeNormal);  //设置本次作画和之前的作画的混色方案，设置成kCGBlendModeNormal表示新的绘画完全覆盖绘画结果之上显示
        CGContextSetRGBStrokeColor(context, _fRed, _fGreen, _fBlue, 1.0); //设置直线颜色
        
        //作画
        CGContextStrokePath(context);
    }
    
    CGContextSaveGState(context);   //保存的数据重新读取到context画板上
    
    //将结果保存到UIImageView上
    self.freeCanvas.image = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束作画
    UIGraphicsEndImageContext();
    _pntBegin = currentPoint;  //这一步很重要，保持作画的连续性 记录新的起点
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];  //随机取一个值
    CGPoint currentPoint = [touch locationInView:self.view];
    
    if(!_bMove) {
        UIGraphicsBeginImageContext(self.freeCanvas.frame.size);
        [self.freeCanvas.image drawInRect:self.freeCanvas.frame];
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        if(_bRubber) {
            CGContextClearRect(context,
                               CGRectMake(currentPoint.x-_rubberWidth,
                                          currentPoint.y - _rubberWidth,
                                          _rubberWidth * 10,
                                          _rubberWidth *10));
        } else {
            CGContextSetLineCap(context, kCGLineCapRound);
            CGContextSetLineWidth(context, _rubberWidth);
            CGContextSetRGBStrokeColor(context, _fRed, _fGreen, _fBlue, 1.0f);
            
            CGContextMoveToPoint(context, _pntBegin.x, _pntBegin.y);
            CGContextAddLineToPoint(context, currentPoint.x, currentPoint.y);
            //开始画图
            CGContextStrokePath(context);
        }
        
        CGContextFlush(context); //强制所有挂起的绘图操作在一个窗口上下文中立即被渲染到目标设备
        
        self.freeCanvas.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
}

- (IBAction)closeHandler:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        _rubberWidth = 0;
        _freeCanvas = nil;
        _colorSegmentControl = nil;
    }];
}
@end
