//
//  ViewController.m
//  Leetcode
//
//  Created by bobzhang 张博 on 2019/8/22.
//  Copyright © 2019 LJ. All rights reserved.
//

#import "ViewController.h"
#import "ListViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
}


- (IBAction)listButtonPressed:(id)sender {
    ListViewController *list = [[ListViewController alloc]init];
    [self.navigationController pushViewController:list animated:YES];
}

@end
