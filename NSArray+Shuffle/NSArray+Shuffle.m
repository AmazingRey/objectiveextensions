//
//  NSMutableArray+Shuffle.m
//  Project T
//
//  Created by Gertjan Leemans on 23/11/12.
//  Copyright (c) 2012 Gertjan Leemans. All rights reserved.
//

#import "NSArray+Shuffle.h"

@implementation NSArray(Shuffle)

- (NSArray *)shuffledArray
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    
    NSMutableArray *copy = [self mutableCopy];
    while ([copy count] > 0)
    {
        int index = arc4random() % [copy count];
        id objectToMove = [copy objectAtIndex:index];
        [array addObject:objectToMove];
        [copy removeObjectAtIndex:index];
    }
    
    return array;
}

@end
