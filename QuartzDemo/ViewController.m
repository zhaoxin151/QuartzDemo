//
//  ViewController.m
//  QuartzDemo
//
//  Created by naton on 2017/3/8.
//  Copyright © 2017年 com.naton.haibo. All rights reserved.
//

#import "ViewController.h"
#import "DrawFreeViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"DrawFreeViewController"]) {
        DrawFreeViewController *drawFree = segue.destinationViewController;
        //可以在这里传值 sender
    }
}


- (IBAction)drawSomethingHandler:(id)sender {
    [self performSegueWithIdentifier:@"DrawFreeViewController" sender:nil];
}
- (IBAction)drawGraphHandler:(UIButton *)sender {
    [self performSegueWithIdentifier:@"DrawGraphViewController" sender:nil];
}
//颜色渐变
- (IBAction)gridentHandler:(id)sender {
     [self performSegueWithIdentifier:@"gradient" sender:nil];
}
@end
