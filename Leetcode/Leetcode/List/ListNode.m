//
//  ListNode.m
//  Leetcode
//
//  Created by bobzhang 张博 on 2019/8/23.
//  Copyright © 2019 LJ. All rights reserved.
//

#import "ListNode.h"

@implementation ListNode

+ (ListNode *)creatListNodeForm:(NSArray *)array {
    if (array.count <= 0) {
        return nil;
    }
    ListNode *listNode = [[ListNode alloc]init];
    ListNode *previousNode = listNode;
    for (int i = 0; i < array.count; i++) {
        if (i == 0) {
            listNode.value = [array[i] integerValue];
        } else {
            ListNode *nextNode = [[ListNode alloc]init];
            nextNode.value = [array[i] integerValue];
            previousNode.next = nextNode;
            previousNode = nextNode;
        }
        
    }
    return listNode;
}

- (void)printAllListNode {
    ListNode *nextNode = self;
    while (nextNode) {
        NSLog(@"-->%ld",(long)nextNode.value);
        nextNode = nextNode.next;
    }
}

@end
