//
//  UIAlertView+Blocks.h
//  Gertjan Leemans
//
//  Created by Gertjan Leemans on 28/11/12.
//  Copyright 2012 Gertjan Leemans, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIAlertViewButtonItem.h"

@interface UIAlertView (Blocks)

- (id) initWithTitle: (NSString *) inTitle message: (NSString *) inMessage cancelButtonItem: (UIAlertViewButtonItem *) inCancelButtonItem otherButtonItems: (UIAlertViewButtonItem *) inOtherButtonItems, ... NS_REQUIRES_NIL_TERMINATION;

- (NSInteger) addButtonItem: (UIAlertViewButtonItem *) item;

@end
