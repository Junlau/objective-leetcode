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
    
    ListNode *listNode1 = [ListNode creatListNodeForm:@[@1,@2,@3,@4,@5,@6]];
    ListNode *listNode2 = [ListNode creatListNodeForm:@[@5,@6,@4]];
    self.originalLabel.text = [listNode1 printAllListNode];
    self.afterLabel.text = [[self rotateList:listNode1 index:2] printAllListNode];
    
    //创建一个有环的链表
    ListNode *cycleNodel = [ListNode creatListNodeForm:@[@1,@2,@3,@4,@5,@6]];
    ListNode *p = cycleNodel;
    ListNode *secondNext = cycleNodel.next;
    while (p.next != nil) {
        p = p.next;
    }
    p.next = secondNext;
    if ([self hasCycle:cycleNodel]) {
        self.afterLabel.text = @"链表有环";
    } else {
        self.afterLabel.text = @"链表没环";
    }
    
    self.afterLabel.text = [[self delectCycle:cycleNodel] printAllListNode];
    
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

//头插法
- (ListNode *)reverseLinkedList:(ListNode *)head {
    ListNode *resultList = [[ListNode alloc]init];
    resultList.next = head;
    ListNode *nextNode = head.next;
    while (nextNode) {
        head.next = nextNode.next;
        nextNode.next = resultList.next;
        resultList.next = nextNode;
        
        nextNode = head.next;
    }
    
    resultList = resultList.next;
    return resultList;
}

//直接从头到尾转换
- (ListNode *)reverseLinkedList2:(ListNode *)head {
    ListNode *preNode = nil; //上一个
    
    while (head) {
        ListNode *nextNode = head.next; //下一个
        head.next = preNode;
        preNode = head;
        head = nextNode;
    }

    return preNode;
}


/*
 92. Reverse Linked List II
 
 
 Reverse a linked list from position m to n. Do it in one-pass.
 
 Note: 1 ≤ m ≤ n ≤ length of list.
 
 Example:
 
 Input: 1->2->3->4->5->NULL, m = 2, n = 4
 Output: 1->4->3->2->5->NULL

 */

- (ListNode *)reverseLinkedList:(ListNode *)head form:(NSInteger)formIndex to:(NSInteger)toIndex {
    if (head == nil || head.next == nil || formIndex == toIndex) {
        return head;
    }
    
    if (formIndex < 0 || toIndex < 0 || formIndex > toIndex) {
        return head;
    }
    
    ListNode *resultList = head;
    ListNode *perFormNode = nil;
    ListNode *curNode = resultList;
    ListNode *nextNode = nil;
    
    if (formIndex == 1) {
        perFormNode = [[ListNode alloc]init];
        perFormNode.next = curNode;
    }
    
    for (int i = 1; i<toIndex; i++) {
        if (i == formIndex - 1) {
            perFormNode = curNode;
        }
        
        if (i >= formIndex) {
            nextNode = curNode.next;
            curNode.next = nextNode.next;
            nextNode.next = perFormNode.next;
            perFormNode.next = nextNode;
        } else {
            curNode = curNode.next;
        }
        
        if (curNode == nil) {
            break;
        }
        
    }
    
    if (formIndex == 1) {
        resultList = perFormNode.next;
    }
    
    return resultList;
}

- (ListNode *)reverseLinkedList2:(ListNode *)head form:(NSInteger)formIndex to:(NSInteger)toIndex {
    if (head == nil || head.next == nil || formIndex == toIndex) {
        return head;
    }
    
    if (formIndex < 0 || toIndex < 0 || formIndex > toIndex) {
        return head;
    }
    
    ListNode *resultList = [[ListNode alloc]init];
    resultList.next = head;
    
    ListNode *perFormNode = nil;
    
    ListNode *nextToNode = nil;
    
    ListNode *p = resultList;
    int count = 0;
    while (p != nil) {
        if (count == formIndex) {
            int temp = 0;
            ListNode *tempNode = nil;
            ListNode *curNode = p;
            while (curNode != nil && temp < (toIndex - formIndex)+1) {
                nextToNode = curNode.next;
                curNode.next = tempNode;
                tempNode = curNode;
                curNode = nextToNode;
                
                temp++;
            }
            
            perFormNode.next = tempNode;
            p.next = curNode;
        }
        
        
        perFormNode = p;
        p = p.next;
        count++;
    }
    
    resultList = resultList.next;
    return resultList;
}


/*
 Write a function to delete a node (except the tail) in a singly linked list,
 
 given only access to that node.
 
 Given linked list -- head = [4,5,1,9], which looks like following:
 
 4->5->1->9
 
 Example 1:
 
 Input: head = [4,5,1,9], node = 5
 
 Output: [4,1,9]
 
 Explntion: You are given the seond node with value 5, the linked list should
 
 become 4 -> 1 -> 9 after calling your function.
 
 Example 2:
 
 Input: head = [4,5,1,9], node = 1
 
 Output: [4,5,9]
 
 Explntion: You are given the third node with value 1, the linked list should
 
 become 4 -> 5 -> 9 after calling your function.
 
 The linked list will have at least two elements.
 
 All of the nodes' values will be unique.
 
 The given node will not be the tail and it will always be a valid node of the linked
 
 list.
 
 Do not return anything from your function.
 */

- (ListNode *)deleteNode:(ListNode *)head dNode:(NSInteger)value {
    ListNode *node = head;
    while (node) {
        if (node.value == value) {
            break;
        }
        node = node.next;
    }
    node.value = node.next.value;
    node.next = node.next.next;
    
    return head;
}


/*
203. Remove Linked List Elements

Remove all elements from a linked list of integers that have value val.

Example:

Input:  1->2->6->3->4->5->6, val = 6
Output: 1->2->3->4->5
*/
- (ListNode *)deleteNode2:(ListNode *)head dNode:(NSInteger)value {
    ListNode *resultNode = [ListNode new];
    resultNode.next = head;
    ListNode *p = resultNode;
    while (p) {
        if (value == p.next.value) {
            p.next = p.next.next;
        } else {
            p = p.next;
        }
    }
    return resultNode.next;
}

/*
 今天的题目是把单链表按奇偶的顺序进行重新组合，奇偶指的是节点的下标而不是节点的值。

 328. Odd Even Linked List
 
 Given a singly linked list, group all odd nodes together followed by the even nodes. Please note here we are talking about the node number and not the value in the nodes.
 You should try to do it in place. The program should run in O(1) space complexity and O(nodes) time complexity.
 
 Example 1:
 Input: 1->2->3->4->5->NULL
 Output: 1->3->5->2->4->NULL

 */

- (ListNode *)oddEvenLinkedList:(ListNode *)head {
    //创建两个新链表，然后再合到一起
    ListNode *firstList = nil;
    ListNode *firstP = nil;
    ListNode *secondList = nil;
    ListNode *secondP = nil;
    
    ListNode * p = head;
    int count = 1;
    while (p) {
        ListNode *curNode = p;
        p = p.next;
        curNode.next = nil; //断链
        if (count%2 != 0) {
            if (firstList == nil) {
                firstList = curNode;
                firstP = firstList;
            } else {
                firstP.next = curNode;
                firstP = firstP.next;
            }
        } else {
            if (secondList == nil) {
                secondList = curNode;
                secondP = secondList;
            } else {
                secondP.next = curNode;
                secondP = secondP.next;
            }
        }
        count++;
    }
    
    firstP.next = secondList;
    return firstList;
}

/*
 今天的题目和以往的思想都不一样，它要求对链表倒数 k 个节点后进行旋转。
 
 61. Rotate List
 
 Given a linked list, rotate the list to the right by k places, where k is non-negative.Example 1:
 
 Input: 1->2->3->4->5->NULL, k = 2
 
 Output: 4->5->1->2->3->NULL
 
 Explanation:
 
 rotate 1 steps to the right: 5->1->2->3->4->NULL
 
 rotate 2 steps to the right: 4->5->1->2->3->NULL
 
 */

- (ListNode *)rotateList:(ListNode *)head index:(NSInteger)index {
    //先将链表形成一个闭环，然后再移动几步
    ListNode *resultNode = nil;
    ListNode *p = head;
    int listCount = 1;//链表总长度
    while (p.next != nil) {
        listCount++;
        p = p.next;
    }
    p.next = head; //链表闭环
    int headIndex = listCount - index%listCount; //计算步数
    for (int i = 0; i < headIndex; i++) {
        p = p.next;
    }
    resultNode = p.next;
    p.next = nil;
    return resultNode;
}

/*
 Linked List Cycle
 
 链表是否有环，题目的解释可能会把你绕晕，我就不引用原文了。存在环，也就是说链表的 next 指针永远不为空，总会指向链表中某个节点。
 */

- (BOOL)hasCycle:(ListNode *)head {
    BOOL isHave = NO; //默认没有
    //同时遍历，一个快一点一个慢一点，相遇就是有环
    ListNode *slow = head;
    ListNode *fast = head;
    while (slow != nil && fast != nil) {
        slow = slow.next;
        fast = fast.next.next;
        if (slow == fast) {
            isHave = YES;
            break;
        }
    }
    return isHave;
}

/*
 142. Linked List Cycle II
 
 Given a linked list, return the node where the cycle begins. If there is no cycle, return null.
 
 下图中链表存在环，题目的要求是找出 4 这个点(环点，相遇的点)，当然如果链表不存在环，也就不会存在环的起点。
 */

- (ListNode *)delectCycle:(ListNode *)head {
    ListNode *resultNode = nil;
    ListNode *slow = head;
    ListNode *fast = head;
    BOOL isHave = NO;
    while (slow != nil && fast != nil) {
        slow = slow.next;
        fast = fast.next.next;
        if (slow == fast) {
            isHave = YES;
            break;
        }
    }
    if (!isHave) {
        return nil;
    }
    //当两个相等之后，把慢的那个指向头结点，快的那个依旧指向相遇结点，从新开始遍历，再次相等的那个就是环点（算法）
    //另一种方法是把各个结点放到字典中，能重复取出来的就是环点
    slow = head;
    while (slow != fast) {
        slow = slow.next;
        fast = fast.next;
    }
    resultNode = slow;
    resultNode.next = nil;
    
    return resultNode;
}

@end
