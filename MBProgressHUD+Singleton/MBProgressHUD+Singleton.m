//
//  Copyright (c) 2012 Gertjan Leemans
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//  MBProgressHUD+Singleton.m
//
//  Created by Gertjan Leemans on 03/06/13.
//

#import "MBProgressHUD+Singleton.h"

@implementation MBProgressHUD (Singleton)

static MBProgressHUD* shared = NULL;

+ (MBProgressHUD *)sharedInstance{
    @synchronized(shared){
        if(!shared || shared == NULL){            
            if([[UIApplication sharedApplication].delegate respondsToSelector: @selector(window)]){
                UIWindow* window = [[UIApplication sharedApplication].delegate window];
                if(!window){
                    @throw [NSException exceptionWithName: @"WindowNotFoundException" reason: @"No window set on UIApplication delegate" userInfo:nil];
                }
                shared = [MBProgressHUD sharedInstanceOnWindow: window];
            } else {
                @throw [NSException exceptionWithName: @"WindowNotFoundException" reason: @"No selector for window found on UIApplication delegate" userInfo:nil];
            }
        }
        return shared;
    }
}

+ (MBProgressHUD *)sharedInstanceOnWindow:(UIWindow *)window{
    @synchronized(shared){
        if(!shared || shared == NULL){
            shared = [[MBProgressHUD alloc] initWithWindow: window];
            [window addSubview: shared];
            shared.delegate = shared;
        }
        return shared;
    }
}

#pragma mark - MBProgressHUDDelegate

- (void)hudWasHidden:(MBProgressHUD *)hud{
    [shared removeFromSuperview];
    shared = NULL;
}

@end
