//
//  DrawGraphViewController.m
//  QuartzDemo
//
//  Created by naton on 2017/3/8.
//  Copyright © 2017年 com.naton.haibo. All rights reserved.
//

#import "DrawGraphViewController.h"
#import "DrawGraphView.h"

@interface DrawGraphViewController ()

@property (weak, nonatomic) IBOutlet DrawGraphView *graphView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *graphSegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *colorSegment;

@property (nonatomic, assign) NSInteger colorSelectIndex;

@end

@implementation DrawGraphViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self graphSegementChange:self.graphSegment];
    [self colorSegmentChange:self.colorSegment];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closeDrawGraphHandler:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)graphSegementChange:(id)sender {
    UISegmentedControl *segment = sender;
    NSInteger index = segment.selectedSegmentIndex;
    switch (index) {
        case 0:
            _graphView.type = kLineGraph;
            break;
        case 1:
            _graphView.type = kRectGraph;
            break;
            
        case 2:
            _graphView.type = kRoundGraph;
            break;
        default:
            break;
    }
}

- (IBAction)colorSegmentChange:(id)sender {
    
    UISegmentedControl *segment = sender;
    NSInteger index = segment.selectedSegmentIndex;
    switch (index) {
        case 0:
            _graphView.color = [UIColor redColor];
            break;
        case 1:
            _graphView.color = [UIColor yellowColor];
            break;
        default:
            _graphView.color = [UIColor redColor];
            break;
    }

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
