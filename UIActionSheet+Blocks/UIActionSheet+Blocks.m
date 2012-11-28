//
//  Copyright (c) 2012 Gertjan Leemans
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//  UIActionSheet+Blocks.m
//  Gertjan Leemans
//
//  Created by Gertjan Leemans on 28/11/12.
//

#import "UIActionSheet+Blocks.h"
#import <objc/runtime.h>

static NSString *kButtonKey = @"nl.gertjanleemans.UIActionSheet+Blocks";

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
        
        objc_setAssociatedObject(self, (__bridge const void *)(kButtonKey), buttonsArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return self;
}

- (NSInteger) addButtonItem:(UIActionSheetButtonItem *)item{	
    NSMutableArray *buttonsArray = objc_getAssociatedObject(self, (__bridge const void *)(kButtonKey));	
	
	NSInteger buttonIndex = [self addButtonWithTitle:item.label];
	[buttonsArray addObject:item];
	
	return buttonIndex;
}

- (void) actionSheet: (UIActionSheet *) actionSheet didDismissWithButtonIndex: (NSInteger) buttonIndex{
    if (buttonIndex != -1){
        NSArray *buttonsArray = objc_getAssociatedObject(self, (__bridge const void *)(kButtonKey));
        UIActionSheetButtonItem *item = [buttonsArray objectAtIndex:buttonIndex];
        if(item.action){
            item.action();
        }
        objc_setAssociatedObject(self, (__bridge const void *)(kButtonKey), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}


@end
