//
//  UIApplication+TouchEventOverwrite.m
//  MVTouches
//
//  Created by Michael on 9/2/14.
//  Copyright (c) 2014 MichaelVoznesensky. All rights reserved.
//
#import <objc/runtime.h>
#import "UIApplication+TouchEventOverwrite.h"
#import "MVTestAppDelegate.h"

@implementation UIApplication (TouchEventOverwrite)
@dynamic latestViewController;

- (void)setLatestViewController:(id)latestViewController {
    objc_setAssociatedObject(self, @selector(latestViewController), latestViewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)latestViewController {
    return objc_getAssociatedObject(self, @selector(latestViewController));
}

- (void) swizzleSendEvent:(UIEvent*)event {
    [self swizzleSendEvent:event];
    static dispatch_once_t dispatchOnce;
    
    dispatch_once(&dispatchOnce, ^{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCurrentViewController:) name:@"CurrentViewController" object:nil];
    });
    MVTestAppDelegate *appDelegate = (MVTestAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSSet *eventOfTouchesSet = [event touchesForWindow:appDelegate.window];
    for (UITouch *touch in eventOfTouchesSet) {
        if (touch.phase == 0) {
            NSLog(@"I touched the %@ view on the %@ view Controller", touch.view.class, self.latestViewController);
        }
        if (touch.view.class == UIButton.class) {
            touch.view.backgroundColor = [UIColor redColor];
        }
    }
}


+ (void) load {
    Method original, swizzled;
    original = class_getInstanceMethod(self, @selector(sendEvent:));
    swizzled = class_getInstanceMethod(self, @selector(swizzleSendEvent:));
    method_exchangeImplementations(original, swizzled);
}

- (void)handleCurrentViewController:(NSNotification *)notification {
    if([[notification userInfo] objectForKey:@"latestViewController"]) {
        self.latestViewController = [[notification userInfo] objectForKey:@"latestViewController"];
    }
}

@end

/*
 - (void)sendEvent:(UIEvent*)event {
 VESTMyCustomAppDelegate *appDelegate = (VESTMyCustomAppDelegate *)[[UIApplication sharedApplication] delegate];
 NSSet *eventOfTouchesSet = [event touchesForWindow:appDelegate.window];
 for (UITouch *touch in eventOfTouchesSet) {
 NSLog(@"I touched the %@ view on the %@ view Controller", touch.view.class, appDelegate.latestViewController);
 if (touch.view.class == UIButton.class) {
 touch.view.backgroundColor = [UIColor redColor];
 }
 }
 [super sendEvent:event];
 }
 */