//
//  DrawGraphView.h
//  QuartzDemo
//
//  Created by naton on 2017/3/8.
//  Copyright © 2017年 com.naton.haibo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kLineGraph = 0,
    kRectGraph,
    kRoundGraph
} GraphType;

@interface DrawGraphView : UIView

@property (nonatomic , strong) UIColor *color;
@property (nonatomic , assign) GraphType type;

@end
