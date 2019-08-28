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
    
    ListNode *listNode1 = [ListNode creatListNodeForm:@[@2,@4,@3,@1]];
    ListNode *listNode2 = [ListNode creatListNodeForm:@[@5,@6,@4]];
    self.originalLabel.text = [listNode1 printAllListNode];
    self.afterLabel.text = [[self addTwoNumber:listNode1 other:listNode2] printAllListNode];
    
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
    if (l1 == nil) {
        return l2;
    }
    if (l2 == nil) {
        return l1;
    }
    ListNode *allList = nil;
    if (l1.value < l2.value) {
        allList = l1;
        l1 = l1.next;
    } else {
        allList = l2;
        l2 = l2.next;
    }
    ListNode *p = allList;
    while (l1 != nil && l2 != nil) {
        if (l1.value < l2.value) {
            p.next = l1;
            l1 = l1.next;
        } else {
            p.next = l2;
            l2 = l2.next;
        }
        p = p.next;
    }
    
    if (l1 == nil) {
        p.next = l2;
    }
    if (l2 == nil) {
        p.next = l1;
    }
    
    return allList;
}

/*
2. Add Two Numbers

You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.

You may assume the two numbers do not contain any leading zero, except the number 0 itself.

Example: Input: (2 -> 4 -> 3) + (5 -> 6 -> 4) Output: 7 -> 0 -> 8 Explanation: 342 + 465 = 807.
*/

- (ListNode *)addTwoNumber:(ListNode *)l1 other:(ListNode *)l2 {
    if (l1 == nil) {
        return l2;
    }
    if (l2 == nil) {
        return l1;
    }
    ListNode *p = [[ListNode alloc]init];
    ListNode *resultList = p;
    int num = 0; //十进制进位
    while (l1 != nil || l2 != nil) {
        int l1Value = 0;
        if (l1 != nil) {
            l1Value = (int)l1.value;
        }
        int l2Value = 0;
        if (l2 != nil) {
            l2Value = (int)l2.value;
        }
        int sum = l2Value + l1Value + num;
        num = sum/10;
        ListNode *next = [[ListNode alloc]init];
        next.value = sum%10;
        p.next = next;
        p = p.next;
        l1 = l1.next;
        l2 = l2.next;
    }
    if (num > 0) {
        ListNode *last = [[ListNode alloc]init];
        last.value = num;
        p.next = last;
    }
    resultList = resultList.next;
    return resultList;
}

/*
 206. Reverse Linked List
 
 Reverse a singly linked list.
 
 Example:
 
 Input: 1->2->3->4->5->NULL
 Output: 5->4->3->2->1->NULL
 */
- (ListNode *)reverseLinkedList:(ListNode *)head {
    ListNode *resultList = [[ListNode alloc]init];
    
    return ListNode;
}


@end
