//
//  UIAlertViewButtonItem.h
//  Studybuddy
//
//  Created by Gertjan Leemans on 28/11/12.
//  Copyright (c) 2012 Digitalisma. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^UIAlertViewButtonItemAction)();

@interface UIAlertViewButtonItem : NSObject{
    
}

@property (strong, nonatomic)   NSString*                       label;
@property (copy, nonatomic)     UIAlertViewButtonItemAction   action;

+ (id) item;
+ (id) itemWithText: (NSString *) text;
+ (id) itemWithText: (NSString *) text andAction: (UIAlertViewButtonItemAction) action;

@end
