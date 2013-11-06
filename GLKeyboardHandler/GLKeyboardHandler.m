//
//  GLKeyboardHandler.m
//  Spottiapp
//
//  Created by Gertjan Leemans on 24/09/13.
//  Copyright (c) 2013 Digitalisma. All rights reserved.
//

#import "GLKeyboardHandler.h"

@interface GLKeyboardHandler ()

@property (nonatomic, strong) NSMutableArray* delegates;

- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;

- (void)notifySizeChanged:(CGSize)delta notification:(NSNotification *)notification;

@end

@implementation GLKeyboardHandler

static inline UIViewAnimationOptions animationOptionsWithCurve(UIViewAnimationCurve curve){
    switch (curve) {
        case UIViewAnimationCurveEaseInOut:
            return UIViewAnimationOptionCurveEaseInOut;
        case UIViewAnimationCurveEaseIn:
            return UIViewAnimationOptionCurveEaseIn;
        case UIViewAnimationCurveEaseOut:
            return UIViewAnimationOptionCurveEaseOut;
        case UIViewAnimationCurveLinear:
            return UIViewAnimationOptionCurveLinear;
    }
}

SINGLETON_M(GLKeyboardHandler)

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    self.delegates = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Delegate management

- (void)addDelegate:(id<GLKeyboardHandlerDelegate>)delegate{
    [self.delegates addObject: delegate];
}

- (void)removeDelegate:(id<GLKeyboardHandlerDelegate>)delegate{
    [self.delegates removeObject: delegate];
}

#pragma mark - Notifications

- (void)keyboardWillShow:(NSNotification *)notification{
    CGRect oldFrame = self.frame;
    [self retrieveFrameFromNotification:notification];
    
    if (oldFrame.size.height != self.frame.size.height){
        CGSize delta = CGSizeMake(self.frame.size.width - oldFrame.size.width,
                                  self.frame.size.height - oldFrame.size.height);
        
        [self notifySizeChanged:delta notification:notification];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification{
    if (self.frame.size.height > 0.0){
        [self retrieveFrameFromNotification:notification];
        CGSize delta = CGSizeMake(-self.frame.size.width, -self.frame.size.height);
        
        [self notifySizeChanged:delta notification:notification];
    }
    
    self.frame = CGRectZero;
}

#pragma mark - Private methods

- (void)retrieveFrameFromNotification:(NSNotification *)notification{
    CGRect keyboardRect;
    [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardRect];
    self.frame = [[UIApplication sharedApplication].keyWindow.rootViewController.view convertRect:keyboardRect fromView:nil];
}

- (void)notifySizeChanged:(CGSize)delta notification:(NSNotification *)notification{
    NSDictionary *info = [notification userInfo];
    
    UIViewAnimationCurve curve;
    [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&curve];
    
    NSTimeInterval duration;
    [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&duration];
    
    [UIView animateWithDuration: duration delay: 0.0 options: UIViewAnimationOptionCurveEaseIn animations:^{
        for (id<GLKeyboardHandlerDelegate> delegate in self.delegates) {
            if([delegate respondsToSelector: @selector(keyboardSizeChanged:)]){
                [delegate keyboardSizeChanged: delta];
            }
        }
    } completion: nil];
}

@end
