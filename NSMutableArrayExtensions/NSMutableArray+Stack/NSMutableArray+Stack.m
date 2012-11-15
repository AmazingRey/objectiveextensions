//
//  NSMutableArray+Stack.m
//  Gertjan Leemans
//
//  Created by Gertjan Leemans on 15/11/12.
//  Copyright (c) 2012 Gertjan Leemans. All rights reserved.
//

#import "NSMutableArray+Stack.h"

@implementation NSMutableArray (Stack)

- (void) push: (id)item {
    [self addObject:item];
}

- (id) pop {
    id item = nil;
    if ([self count] != 0) {
        item = [self lastObject];
        [self removeLastObject];
    }
    return item;
}

- (id) peek {
    id item = nil;
    if ([self count] != 0) {
        item = [self lastObject];
    }
    return item;
}

@end
