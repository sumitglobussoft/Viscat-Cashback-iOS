//
//  SingletonClass.m
//  Viscat
//
//  Created by Sumit Ghosh on 18/04/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "SingletonClass.h"

static SingletonClass * sharedSingleton;

@implementation SingletonClass

+(SingletonClass *) sharedSingleton{
    @synchronized(self){
        if (!sharedSingleton) {
            sharedSingleton = [[SingletonClass alloc] init];
        }
    }
    
    return sharedSingleton;
}


@end
