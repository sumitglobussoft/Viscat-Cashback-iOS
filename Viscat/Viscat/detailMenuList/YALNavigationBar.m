//
//  YALNavigationBar.m
//  ContextMenu
//
//  Created by Maksym Lazebnyi on 1/22/15.
//  Copyright (c) 2015 Yalantis. All rights reserved.
//

static float const defaultHeight = 65.f;

#import "YALNavigationBar.h"

@implementation YALNavigationBar

- (CGSize)sizeThatFits:(CGSize)size {
    
    CGSize amendedSize = [super sizeThatFits:size];
    amendedSize.height = defaultHeight;
    
    return amendedSize;
}

@end
// Copyright belongs to original author
// http://code4app.net (en) http://code4app.com (cn)
// From the most professional code share website: Code4App.net