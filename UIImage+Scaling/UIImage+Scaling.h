//
//  UIImage+Scaling.h
//  Gertjan Leemans
//
//  Created by Gertjan Leemans on 20/03/12.
//  Copyright (c) 2012 Gertjan Leemans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Scaling)

+ (UIImage *) imageFromView: (UIView*) view;
+ (UIImage *) imageFromView: (UIView*) view scaledToSize: (CGSize) newSize;
+ (UIImage *) imageWithImage: (UIImage*) image scaledToSize: (CGSize) newSize;

@end
