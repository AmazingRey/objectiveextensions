//
//  UIAlertView+Blocks.m
//  Gertjan Leemans
//
//  Created by Gertjan Leemans on 28/11/12.
//  Copyright 2012 Gertjan Leemans, LLC. All rights reserved.
//

#import "UIAlertView+Blocks.h"
#import <objc/runtime.h>

static NSString *GL_BUTTON_ASS_KEY = @"nl.gertjanleemans.UIAlertView+Blocks";

@implementation UIAlertView (Blocks)

- (id) initWithTitle: (NSString *) inTitle message: (NSString *) inMessage cancelButtonItem: (UIAlertViewButtonItem *) inCancelButtonItem otherButtonItems: (UIAlertViewButtonItem *) inOtherButtonItems, ...{
    self = [self initWithTitle:inTitle
                       message:inMessage
                      delegate:self
             cancelButtonTitle:inCancelButtonItem.label
             otherButtonTitles:nil];
    
    if(self){
        NSMutableArray *buttonsArray = [NSMutableArray array];
        
        UIAlertViewButtonItem *eachItem;
        va_list argumentList;
        if (inOtherButtonItems){                                  
            [buttonsArray addObject: inOtherButtonItems];
            va_start(argumentList, inOtherButtonItems);       
            while((eachItem = va_arg(argumentList, UIAlertViewButtonItem *))){
                [buttonsArray addObject: eachItem];            
            }
            va_end(argumentList);
        }    
        
        for(UIAlertViewButtonItem *item in buttonsArray){
            [self addButtonWithTitle:item.label];
        }
        
        if(inCancelButtonItem){
            [buttonsArray insertObject:inCancelButtonItem atIndex:0];
        }
        
        objc_setAssociatedObject(self, (__bridge const void *)(GL_BUTTON_ASS_KEY), buttonsArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [self setDelegate:self];
    }
    return self;
}

- (NSInteger)addButtonItem:(UIAlertViewButtonItem *)item{	
    NSMutableArray *buttonsArray = objc_getAssociatedObject(self, (__bridge const void *)(GL_BUTTON_ASS_KEY));	
	
	NSInteger buttonIndex = [self addButtonWithTitle:item.label];
	[buttonsArray addObject:item];
	
	return buttonIndex;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    NSArray *buttonsArray = objc_getAssociatedObject(self, (__bridge const void *)(GL_BUTTON_ASS_KEY));
    UIAlertViewButtonItem *item = [buttonsArray objectAtIndex:buttonIndex];
    if(item.action)
        item.action();
    objc_setAssociatedObject(self, (__bridge const void *)(GL_BUTTON_ASS_KEY), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
