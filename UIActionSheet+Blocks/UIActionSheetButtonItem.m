//
//  GLButtonItem.m
//  Gertjan Leemans
//
//  Created by Gertjan Leemans on 28/11/12.
//  Copyright 2012 Gertjan Leemans, LLC. All rights reserved.
//

#import "UIActionSheetButtonItem.h"

@implementation UIActionSheetButtonItem

+ (id) item{
    return [[self alloc] init];
}

+ (id) itemWithText: (NSString *) text{
    id newItem = [self item];
    [newItem setLabel: text];
    return newItem;
}

@end

