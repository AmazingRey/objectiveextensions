//
//  MBProgressHUD+Singleton.m
//  MKB App
//
//  Created by Gertjan Leemans on 03/06/13.
//  Copyright (c) 2013 Digitalisma. All rights reserved.
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
