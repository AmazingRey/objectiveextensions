//
//  Copyright (c) 2012 Gertjan Leemans
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//  UIImage+Ret4.m
//
//  Created by Gertjan Leemans on 10/07/13.
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
