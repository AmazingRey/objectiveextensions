//
//  MBProgressHUD+Singleton.h
//  MKB App
//
//  Created by Gertjan Leemans on 03/06/13.
//  Copyright (c) 2013 Digitalisma. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Singleton) <MBProgressHUDDelegate>

+ (MBProgressHUD *) sharedInstance;
+ (MBProgressHUD *) sharedInstanceOnWindow: (UIWindow*) window;

@end
