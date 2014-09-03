//
//  UIViewController+ViewDidAppearOverwrite.m
//  MVTouches
//
//  Created by Michael on 9/2/14.
//  Copyright (c) 2014 MichaelVoznesensky. All rights reserved.
//
#import <objc/runtime.h>
#import "UIViewController+ViewDidAppearOverwrite.h"

@implementation UIViewController (ViewDidAppearOverwrite)

- (void) swizzleDidAppear:(BOOL)animated {
    [self swizzleDidAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CurrentViewController" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:self, @"latestViewController", nil]];
}

+ (void) load {
    Method original, swizzled;
    original = class_getInstanceMethod(self, @selector(viewDidAppear:));
    swizzled = class_getInstanceMethod(self, @selector(swizzleDidAppear:));
    method_exchangeImplementations(original, swizzled);
}

@end
