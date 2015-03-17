//
//  ViewController.m
//  FWPageControl
//
//  Created by Chin on 15/3/16.
//  Copyright (c) 2015年 Chin. All rights reserved.
//

#import "ViewController.h"
#import "FWPageControl.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    FWPageControl *control = [[FWPageControl alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 20)];
    [control setItemSpacing:5];
    [control setContentInset:UIEdgeInsetsMake(9, 10, 9, 10)];
    [control setNumberOfPages:5];
    [self.view addSubview:control];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
