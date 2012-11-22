//
//  Singleton.h
//  Gertjan Leemans
//
//  Created by Gertjan Leemans on 22/11/12.
//  Copyright (c) 2012 Gertjan Leemans. All rights reserved.
//

#define SINGLETON_H(class) + (class *) sharedInstance;
#define SINGLETON_M(class) \
 static class *shared = NULL; \
+ (class *)sharedInstance{ \
    @synchronized(shared){ \
        if ( !shared || shared == NULL ){ \
            shared = [[class alloc] init]; \
        } \
       return shared; \
    } \
}