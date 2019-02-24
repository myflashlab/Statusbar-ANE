//
//  BaseClassStatusbar.m
//  statusbar
//
//  Created by Hadi Tavakoli on 10/26/16.
//  Copyright © 2016 MyFlashLab. All rights reserved.
//

#import "BaseClassStatusbar.h"
#import "exStatusbar.h"
#import "MyFlashLabsClass.h"
#import "NSObject+MHOverride.h"

@implementation BaseClassStatusbar
{
    BOOL _hidden;
    BOOL _isHomeIndicatorAlreadySet;
}

@synthesize okIsTouch;

-(id)init
{
    self = [super init];
    
    // listen to when the bar frame changes
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(statusBarFrameChanged:)
                                                 name:UIApplicationDidChangeStatusBarFrameNotification
                                               object:nil];
    
    return  self;
}

- (void) isTestVersion
{
    // If we know at least one ANE is DEMO, we don't need to show demo dialog again. It's already shown once.
    if([[MyFlashLabsClass sharedInstance] hasAnyDemoAne]) return;
    
    // Check if this ANE is registered?
    if([[MyFlashLabsClass sharedInstance] isAneRegistered:ANE_NAME]) return;
    
    // Otherwise, show the demo dialog.
    
    self.okIsTouch = NO;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DEMO ANE!"
                                                    message:[NSString stringWithFormat:@"The library '%@' is not registered!", ANE_NAME]
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        self.okIsTouch = YES;
    }
}

-(void)hideStatusbar:(BOOL)value withAnimation:(int)animationType
{
    UIStatusBarAnimation type = UIStatusBarAnimationNone;
    
    switch (animationType)
    {
        case 0:
            
            type = UIStatusBarAnimationNone;
            [self performSelector:@selector(dispatchFrameChange) withObject:nil afterDelay:0.1 ]; // setTimeout
            
            break;
        case 1:
            
            type = UIStatusBarAnimationFade;
            [self performSelector:@selector(dispatchFrameChange) withObject:nil afterDelay:1.1 ]; // setTimeout
            
            break;
        case 2:
            
            type = UIStatusBarAnimationSlide;
            [self performSelector:@selector(dispatchFrameChange) withObject:nil afterDelay:1.1 ]; // setTimeout
            
            break;
            
        default:
            break;
    }
    
    [[UIApplication sharedApplication] setStatusBarHidden:value withAnimation:type];
}

-(void)changeStatusbarStyle:(int)barStyle withAnimation:(BOOL)haveAnimation
{
    UIStatusBarStyle style = UIStatusBarStyleDefault;
    
    switch (barStyle) {
        case 1:
            
            style = UIStatusBarStyleDefault;
            
            break;
        case 2:
            
            style = UIStatusBarStyleLightContent;
            
            break;
        default:
            break;
    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:style animated:haveAnimation];
}

-(void)allowHomeIndicatorAutoHide
{
    if(_isHomeIndicatorAlreadySet)
    {
        [self toTrace:@"setting HomeIndicator is only permitted to be called once! other calls will be ignored!"];
        return;
    }
    
    _isHomeIndicatorAlreadySet = YES;
    
    NSOperatingSystemVersion osv = (NSOperatingSystemVersion){11, 0, 0};
    if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:osv])
    {
        UIViewController* rvc = [[UIApplication sharedApplication] keyWindow].rootViewController;
        [rvc mh_overrideSelector:@selector(prefersHomeIndicatorAutoHidden)
                       withBlock:(__bridge void *) ^BOOL(id _self, BOOL animated)
         {
             //[self toTrace:@"allowHomeIndicatorAutoHide OVERRIDE DONE!"];
             return YES;
         }];
        
        //[self toTrace:[NSString stringWithFormat:@"rootViewController -class: %@", NSStringFromClass([rvc class])]];
        //[self toTrace:[NSString stringWithFormat:@"rootViewController objc_getClassName: %s", object_getClassName(rvc)]];
        
        [self toTrace:@"Confirming if OVERRIDE is DONE by calling the property..."];
        BOOL v = rvc.prefersHomeIndicatorAutoHidden;
        [rvc setNeedsUpdateOfHomeIndicatorAutoHidden];
        
        if(v) [self toTrace:@"allowHomeIndicatorAutoHide OVERRIDE DONE!"];
        else [self toTrace:@"allowHomeIndicatorAutoHide OVERRIDE is NOT DONE!!!"];
    }
    else
    {
        [self toTrace:@"'prefersHomeIndicatorAutoHidden' is only available on iOS 11.0 or newer"];
    }
}

-(void)dispose
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidChangeStatusBarFrameNotification
                                                  object:nil];
}

-(double)statusBarHeight
{
    CGSize statusBarSize = [[UIApplication sharedApplication] statusBarFrame].size;
    
    float statusBarHeight = MIN(statusBarSize.width, statusBarSize.height);
    
    [[MyFlashLabsClass sharedInstance] toTrace:ANE_NAME
                                     className:NSStringFromClass([self class])
                                           msg:[NSString stringWithFormat:@"statusBarHeight = %f", statusBarHeight * 96 / 72]];
    
    
    return (double)statusBarHeight;
}

- (void)statusBarFrameChanged:(NSNotification*)notification
{
    [self dispatchFrameChange];
    [self statusBarHeight];
    
}

-(void)dispatchFrameChange
{
    // let AIR know that Statusbar frame has changed
    [exStatusbar dispatchEventEcode:FRAME_CHANGED andElevel:@""];
}

-(void)toTrace:(NSString*)value
{
    [[MyFlashLabsClass sharedInstance] toTrace:ANE_NAME
                                     className:NSStringFromClass([self class])
                                           msg:value];
}

@end
