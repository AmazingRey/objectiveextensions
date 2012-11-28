//
//  GLButtonItem.h
//  Gertjan Leemans
//
//  Created by Gertjan Leemans on 28/11/12.
//  Copyright 2012 Gertjan Leemans, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^UIActionSheetButtonItemAction)();

@interface UIActionSheetButtonItem : NSObject

@property (strong, nonatomic)   NSString*                       label;
@property (copy, nonatomic)     UIActionSheetButtonItemAction   action;

+ (id) item;
+ (id) itemWithText: (NSString *) text;

@end

