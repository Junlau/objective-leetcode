//
//  ListViewController.m
//  Leetcode
//
//  Created by bobzhang 张博 on 2019/8/27.
//  Copyright © 2019 LJ. All rights reserved.
//

#import "ListViewController.h"
#import "ListNode.h"

@interface ListViewController ()
@property (nonatomic, strong) UILabel *originalLabel;
@property (nonatomic, strong) UILabel *afterLabel;
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.originalLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 0)];
    self.originalLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.originalLabel];
    self.afterLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
    self.afterLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.afterLabel];
    
    ListNode *listNode = [ListNode creatListNodeForm:@[@1,@1,@2,@2,@3,@3,@4,@4,@7]];
    self.originalLabel.text = [listNode printAllListNode];
    self.afterLabel.text = [[self deleteDuplicates2:listNode] printAllListNode];
    
}

- (void)viewDidLayoutSubviews {
    [self.originalLabel sizeToFit];
    [self.afterLabel sizeToFit];
    self.originalLabel.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, self.originalLabel.frame.size.height);
    self.afterLabel.frame = CGRectMake(0, CGRectGetMaxY(self.originalLabel.frame), [UIScreen mainScreen].bounds.size.width, self.afterLabel.frame.size.height);
}

/*
 Given a sorted linked list, delete all duplicates such that each element appear only once.
 
 Example 1:
 
 Input: 1->1->2
 Output: 1->2
 */
- (ListNode *)deleteDuplicates:(ListNode *)head {
    if (head == nil || head.next == nil) {
        return head;
    }
    ListNode *perNode = head;
    ListNode *nextNode = head.next;
    while (nextNode) {
        if (perNode.value == nextNode.value) {
            perNode.next = nextNode.next;
            nextNode = perNode.next;
        } else {
            perNode = perNode.next;
            nextNode = nextNode.next;
        }
    }
    return head;
}

/*
 Given a sorted linked list, delete all nodes that have duplicate numbers, leaving only distinct numbers from the original list.
 
 Example 1: Input: 1->2->3->3->4->4->5 Output: 1->2->5
 
 Example 2: Input: 1->1->1->2->3 Output: 2->3
 
*/
- (ListNode *)deleteDuplicates2:(ListNode *)head {
    if (head == nil || head.next == nil) {
        return head;
    }
    
    ListNode *resultNode = nil; //创造一个新的单链表
    ListNode *p = nil;
    ListNode *lastRepate = nil;
    while (head) {
        if ((head.next != nil && head.value != head.next.value) || head.next == nil) {
            if (lastRepate == nil || lastRepate.value != head.value) {
                if (p == nil) {
                    resultNode = head;
                    p = resultNode;
                } else {
                    p.next = head;
                    p = p.next;
                }
            }
        } else {
            lastRepate = head;
        }
        
        head = head.next;
    }
    return resultNode;
    
}

/*
Merge two sorted linked lists and return it as a new list. The new list should be made by splicing together the nodes of the first two lists.

Example:

Input: 1->2->4, 1->3->4
Output: 1->1->2->3->4->4
 
*/
- (ListNode *)mergoTwoList:(ListNode *)l1 other:(ListNode *)l2 {
    
    ListNode *allList = nil;
    
    return allList;
}


@end
