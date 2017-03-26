//
//  ViewController.m
//  ZBPieAnimationView
//
//  Created by zhanbing han on 17/3/26.
//  Copyright © 2017年 cydf. All rights reserved.
//

#import "ViewController.h"
#import "ZBPieView.h"

@interface ViewController ()

@property (nonatomic,assign) float percent;
@property (nonatomic,strong) ZBPieView *pieView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.percent = 1-0.62;
    self.pieView = [[ZBPieView alloc] initWithFrame:CGRectMake(50, 100, 100, 100) andPercent:self.percent andColor:[UIColor blueColor]];
    [self.view addSubview:self.pieView];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"重新加载" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickReload) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(200, 300, 100, 50);
    [self.view addSubview:button];
}

-(void)clickReload {
    self.percent -= 0.1;
    [self.pieView reloadViewWithPercent:self.percent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
