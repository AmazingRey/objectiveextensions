//
//  UIActionSheet+Blocks.h
//  Gertjan Leemans
//
//  Created by Gertjan Leemans on 28/11/12.
//  Copyright 2012 Gertjan Leemans, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIActionSheetButtonItem.h"

@interface UIActionSheet (Blocks) <UIActionSheetDelegate>

- (id) initWithTitle:(NSString *)inTitle cancelButtonItem: (UIActionSheetButtonItem *) inCancelButtonItem destructiveButtonItem: (UIActionSheetButtonItem *) inDestructiveItem otherButtonItems: (UIActionSheetButtonItem *)inOtherButtonItems, ... NS_REQUIRES_NIL_TERMINATION;

- (NSInteger) addButtonItem:(UIActionSheetButtonItem *)item;

@end
