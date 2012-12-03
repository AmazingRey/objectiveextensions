//
//  Copyright (c) 2012 Gertjan Leemans
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//  GLKeychain.m
//  Gertjan Leemans
//
//  Created by Gertjan Leemans on 29/11/12.
//
//  Based on Keychain class from the OpenStack (Rackspace) project
//	https://github.com/rackspace/rackspace-ios
//

#import "GLKeychain.h"
#import <Security/Security.h>

@interface GLKeychain ()

+ (NSString *)appName;
+ (NSMutableDictionary *)dictionaryBaseForKey:(NSString *)aKey;
+ (NSMutableDictionary *)dictionaryBaseForKey:(NSString *)aKey skipClass:(BOOL)aSkipClass;

@end

@implementation GLKeychain

#pragma mark - Private functions

+ (NSString *)appName {
	NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
	// Attempt to find a name for this application
	NSString *appName = [bundle objectForInfoDictionaryKey:@"CFBundleDisplayName"];
	if (!appName) {
		appName = [bundle objectForInfoDictionaryKey:@"CFBundleName"];
	}
    return appName;
}

+ (NSMutableDictionary *)dictionaryBaseForKey:(NSString *)aKey {
    
	return [GLKeychain dictionaryBaseForKey:aKey skipClass:NO];
}

+ (NSMutableDictionary *)dictionaryBaseForKey:(NSString *)aKey skipClass:(BOOL)aSkipClass {
	NSMutableDictionary *searchDictionary = [NSMutableDictionary new];
	
	[searchDictionary setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
	[searchDictionary setObject:[GLKeychain appName] forKey:(__bridge id)kSecAttrService];
	[searchDictionary setObject:aKey forKey:(__bridge id)kSecAttrAccount];
    
    return searchDictionary;
}

#pragma mark - Public functions

+ (OSStatus)valueStatusForKey:(NSString *)aKey {
	NSDictionary *searchDictionary = [GLKeychain dictionaryBaseForKey:aKey];
	return SecItemCopyMatching((__bridge CFDictionaryRef)searchDictionary, nil);
}

+ (BOOL)hasValueForKey:(NSString *)aKey {
    
	return ([GLKeychain valueStatusForKey:aKey] == errSecSuccess);
}

+ (BOOL)setSecureValue:(id)aValue forKey:(NSString *)aKey {
	if (aValue == nil || aKey == nil){
        return NO;
    }
    
	NSData *valueData = [NSKeyedArchiver archivedDataWithRootObject:aValue];
    
	OSStatus valStatus = [GLKeychain valueStatusForKey:aKey];
	if (valStatus == errSecItemNotFound) {   
		NSMutableDictionary *addQueryDict = [GLKeychain dictionaryBaseForKey:aKey];
		[addQueryDict setObject:valueData forKey:(__bridge id)kSecValueData];
        
		valStatus = SecItemAdd ((__bridge CFDictionaryRef)addQueryDict, NULL);
		NSAssert1(valStatus == errSecSuccess, @"Value add returned status %ld", valStatus);
	} else if (valStatus == errSecSuccess) {
		NSMutableDictionary *updateQueryDict = [GLKeychain dictionaryBaseForKey:aKey];
		NSDictionary *valueDict = [NSDictionary dictionaryWithObject:valueData forKey:(__bridge id)kSecValueData];
		
		valStatus = SecItemUpdate ((__bridge CFDictionaryRef)updateQueryDict, (__bridge CFDictionaryRef)valueDict);
		NSAssert1(valStatus == errSecSuccess, @"Value update returned status %ld", valStatus);
		
	} else {
		NSAssert2(NO, @"Received mismatched status (%ld) while setting keychain value for key %@", valStatus, aKey);
	}
    
	return YES;
}

+ (id)secureValueForKey:(NSString *)aKey {
	NSMutableDictionary *retrieveQueryDict = [GLKeychain dictionaryBaseForKey:aKey];
	[retrieveQueryDict setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    
	CFDataRef dataRef = nil;
	OSStatus queryResult = SecItemCopyMatching ((__bridge CFDictionaryRef)retrieveQueryDict, (CFTypeRef *)&dataRef);
	if (queryResult == errSecSuccess) {
		NSData *valueData = (__bridge NSData *)dataRef;
		id value = [NSKeyedUnarchiver unarchiveObjectWithData:valueData];
		return value;
	} else {
		NSAssert2(queryResult == errSecItemNotFound, @"Received mismatched status (%ld) while retrieving keychain value for key %@", queryResult, aKey);
	}
	
	return nil;
}

+ (BOOL)removeSecureValueForKey:(NSString *)aKey {
	
	NSDictionary *deleteQueryDict = [GLKeychain dictionaryBaseForKey:aKey];
    OSStatus queryResult = SecItemDelete((__bridge CFDictionaryRef)deleteQueryDict);
	if (queryResult == errSecSuccess) {
		return YES;
	} else {
		NSAssert2(queryResult == errSecItemNotFound, @"Received mismatched status (%ld) while deleting keychain value for key %@", queryResult, aKey);
		return NO;
	}
}

@end
