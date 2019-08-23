//
//  ViewController.m
//  Leetcode
//
//  Created by bobzhang 张博 on 2019/8/22.
//  Copyright © 2019 LJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ListNode *listNode = [ListNode creatListNodeForm:@[@1,@2,@3,@4,@5,@6,@7]];
    [listNode printAllListNode];
}


@end
