//
//  ResigningUIImageView.m
//  WhatAppened
//
//  Created by Gertjan Leemans on 03/04/12.
//  Copyright (c) 2012 WhatAppened. All rights reserved.
//

#import "ResigningUIImageView.h"

@implementation ResigningUIImageView

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if(self.superview){
        [ResigningUIImageView resignSubViewsOfView: self.superview];
    }
    if(self.delegate){
        if([self.delegate respondsToSelector: @selector(didResign:)]){
            [self.delegate didResign: self];
        }
    }
}

+ (void) resignSubViewsOfView: (UIView *) view{
    for (UIView *subview in view.subviews) {
        [subview resignFirstResponder];
        [self resignSubViewsOfView: subview];
    }
}

@end
