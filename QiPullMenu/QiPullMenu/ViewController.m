//
//  ViewController.m
//  QiPullMenu
//
//  Created by qi on 15/6/3.
//  Copyright (c) 2015年 im.qihf. All rights reserved.
//

#import "ViewController.h"
#import "QiPullMenu-Swift.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property(nonatomic,strong)QiPullMenu* pullMenu;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _pullMenu=[[QiPullMenu alloc]initWithScrollView:_scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
