//
//  NSMutableArray+Queue.m
//  Studybuddy
//
//  Created by Gertjan Leemans on 15/11/12.
//  Copyright (c) 2012 Digitalisma. All rights reserved.
//

#import "NSMutableArray+Queue.h"

@implementation NSMutableArray (Queue)

- (void) enqueue: (id)item {
    [self addObject:item];
}

- (id) dequeue {
    id item = nil;
    if ([self count] != 0) {
        item = [self objectAtIndex:0];
        [self removeObjectAtIndex:0];
    }
    return item;
}

- (id) peek {
    id item = nil;
    if ([self count] != 0) {
        item = [self objectAtIndex:0];
    }
    return item;
}

@end
