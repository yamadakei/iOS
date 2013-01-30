//
//  NSMutableArray+Sort.m
//  FlickrCollectionView
//
//  Created by 山田 慶 on 2013/01/30.
//  Copyright (c) 2013年 山田 慶. All rights reserved.
//

#import "NSMutableArray+Sort.h"

@implementation NSMutableArray (Sort)

- (void)removeDuplicatedObjects
{
    NSMutableIndexSet* removedIndexes = [[NSMutableIndexSet alloc] init];
    NSMutableSet* set = [[NSMutableSet alloc] init];
    const NSUInteger count = [self count];
    for (NSUInteger i = 0; i < count; i++) {
        id object = [self objectAtIndex:i];
        if ([set containsObject:object]) {
            [removedIndexes addIndex:i];
        } else {
            [set addObject:object];
        }
    }
    [self removeObjectsAtIndexes:removedIndexes];
}

@end
