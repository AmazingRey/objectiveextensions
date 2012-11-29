//
//  Copyright (c) 2012 Gertjan Leemans
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//  GLKeychain.h
//  Gertjan Leemans
//
//  Created by Gertjan Leemans on 29/11/12.
//
//  Based on Keychain class from the OpenStack (Rackspace) project
//	https://github.com/rackspace/rackspace-ios
//

#import <Foundation/Foundation.h>

@interface GLKeychain : NSObject

+ (BOOL) setSecureValue: (id)value forKey: (NSString *) key;
+ (id) secureValueForKey: (NSString *) key;
+ (BOOL) removeSecureValueForKey: (NSString *) aKey;
+ (OSStatus) valueStatusForKey: (NSString *) aKey;
+ (BOOL) hasValueForKey: (NSString *) aKey;

@end