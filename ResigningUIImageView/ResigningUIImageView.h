//
//  ResigningUIImageView.h
//  WhatAppened
//
//  Created by Gertjan Leemans on 03/04/12.
//  Copyright (c) 2012 WhatAppened. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ResigningUIImageView;

@protocol ResigningUIImageViewDelegate <NSObject>

@optional

- (void) didResign: (ResigningUIImageView*) resigningUIImageView;

@end


@interface ResigningUIImageView : UIImageView{
    
}

@property (nonatomic, assign) id<ResigningUIImageViewDelegate> delegate;

+ (void) resignSubViewsOfView: (UIView *) view;

@end
