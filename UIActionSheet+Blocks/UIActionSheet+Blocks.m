//
//  UIActionSheet+Blocks.m
//  Gertjan Leemans
//
//  Created by Gertjan Leemans on 28/11/12.
//  Copyright 2012 Gertjan Leemans, LLC. All rights reserved.
//

#import "UIActionSheet+Blocks.h"
#import <objc/runtime.h>

static NSString *GL_BUTTON_ASS_KEY = @"nl.gertjanleemans.UIActionSheet+Blocks";

@implementation UIActionSheet (Blocks)

-(id)initWithTitle: (NSString *) inTitle cancelButtonItem: (UIActionSheetButtonItem *) inCancelButtonItem destructiveButtonItem: (UIActionSheetButtonItem *) inDestructiveItem otherButtonItems: (UIActionSheetButtonItem *) inOtherButtonItems, ...{
    self = self = [self initWithTitle:inTitle
                             delegate:self
                    cancelButtonTitle:nil
               destructiveButtonTitle:nil
                    otherButtonTitles:nil];
    
    if(self){
        NSMutableArray *buttonsArray = [NSMutableArray array];
        
        UIActionSheetButtonItem *eachItem;
        va_list argumentList;
        if (inOtherButtonItems){
            [buttonsArray addObject: inOtherButtonItems];
            va_start(argumentList, inOtherButtonItems);
            while((eachItem = va_arg(argumentList, UIActionSheetButtonItem *))){
                [buttonsArray addObject: eachItem];
            }
            va_end(argumentList);
        }
        
        for(UIActionSheetButtonItem *item in buttonsArray){
            [self addButtonWithTitle:item.label];
        }
        
        if(inDestructiveItem){
            [buttonsArray addObject:inDestructiveItem];
            NSInteger destIndex = [self addButtonWithTitle:inDestructiveItem.label];
            [self setDestructiveButtonIndex:destIndex];
        }
        
        if(inCancelButtonItem){
            [buttonsArray addObject:inCancelButtonItem];
            NSInteger cancelIndex = [self addButtonWithTitle:inCancelButtonItem.label];
            [self setCancelButtonIndex:cancelIndex];
        }
        
        objc_setAssociatedObject(self, (__bridge const void *)(GL_BUTTON_ASS_KEY), buttonsArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return self;
}

- (NSInteger) addButtonItem:(UIActionSheetButtonItem *)item{	
    NSMutableArray *buttonsArray = objc_getAssociatedObject(self, (__bridge const void *)(GL_BUTTON_ASS_KEY));	
	
	NSInteger buttonIndex = [self addButtonWithTitle:item.label];
	[buttonsArray addObject:item];
	
	return buttonIndex;
}

- (void) actionSheet: (UIActionSheet *) actionSheet didDismissWithButtonIndex: (NSInteger) buttonIndex{
    if (buttonIndex != -1){
        NSArray *buttonsArray = objc_getAssociatedObject(self, (__bridge const void *)(GL_BUTTON_ASS_KEY));
        UIActionSheetButtonItem *item = [buttonsArray objectAtIndex:buttonIndex];
        if(item.action){
            item.action();
        }
        objc_setAssociatedObject(self, (__bridge const void *)(GL_BUTTON_ASS_KEY), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}


@end
