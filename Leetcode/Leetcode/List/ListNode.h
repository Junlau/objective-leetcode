//
//  ListNode.h
//  Leetcode
//
//  Created by bobzhang 张博 on 2019/8/23.
//  Copyright © 2019 LJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListNode : NSObject
@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) ListNode *next;

+ (ListNode *)creatListNodeForm:(NSArray *)array;

- (void)printAllListNode;
@end

NS_ASSUME_NONNULL_END
