//
//  UIImage+Ret4.m
//  MKBApp
//
//  Created by Gertjan Leemans on 10/07/13.
//  Copyright (c) 2013 Digitalisma. All rights reserved.
//

#import "UIImage+Ret4.h"

@implementation UIImage (Ret4)

+ (UIImage *)deviceSpecificImageWithName:(NSString *)imageName{
    NSMutableString *imageNameMutable = [imageName mutableCopy];
    NSRange retinaAtSymbol = [imageName rangeOfString:@"@"];
    if (retinaAtSymbol.location != NSNotFound) {
        [imageNameMutable insertString:@"-568h" atIndex:retinaAtSymbol.location];
    } else {
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        
        NSString *deviceType = [UIDevice currentDevice].model;
        
        if([deviceType rangeOfString: @"iPad"].location != NSNotFound){
            [imageNameMutable appendString:@"_ipad"];
        } else {
            if ([UIScreen mainScreen].scale == 2.f && screenHeight == 568.0f) {
                NSRange dot = [imageName rangeOfString:@"."];
                if (dot.location != NSNotFound) {
                    [imageNameMutable insertString:@"-568h@2x" atIndex:dot.location];
                } else {
                    [imageNameMutable appendString:@"-568h@2x"];
                }
            }
        }
    }
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageNameMutable ofType:@"png"];
    if (imagePath) {
        return [UIImage imageNamed: imageNameMutable];
    } else {
        return [UIImage imageNamed: imageName];
    }
    return nil;
}

@end
