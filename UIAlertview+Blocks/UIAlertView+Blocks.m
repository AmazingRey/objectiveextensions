//
//  Copyright (c) 2012 Gertjan Leemans
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//  UIAlertView+Blocks.m
//  Gertjan Leemans
//
//  Created by Gertjan Leemans on 28/11/12.
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
