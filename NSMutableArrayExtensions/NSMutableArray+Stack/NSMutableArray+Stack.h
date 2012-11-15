//
//  NSMutableArray+Stack.h
//  Gertjan Leemans
//
//  Created by Gertjan Leemans on 15/11/12.
//  Copyright (c) 2012 Gertjan Leemans. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Stack)

- (void) push: (id)item;
- (id) pop;
- (id) peek;

@end
