//
//  UIAlertViewButtonItem.m
//  Studybuddy
//
//  Created by Gertjan Leemans on 28/11/12.
//  Copyright (c) 2012 Digitalisma. All rights reserved.
//

#import "UIAlertViewButtonItem.h"

@implementation UIAlertViewButtonItem

+ (id) item{
    return [[self alloc] init];
}

+ (id) itemWithText: (NSString *) text{
    id newItem = [self item];
    [newItem setLabel: text];
    return newItem;
}

+ (id)itemWithText:(NSString *)text andAction:(UIAlertViewButtonItemAction)action{
    UIAlertViewButtonItem* newItem = [self itemWithText: text];
    [newItem setAction: action];
    return newItem;
}

@end
