//
//  ViewController.m
//  statusbar
//
//  Created by MyFlashLab on 8/2/16.
//  Copyright © 2016 MyFlashLab. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    BOOL _hidden;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    //UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    //rootViewController.navigationController.navigationBarHidden = YES;
    
    
    // this is not a good solution because it is using the private library
    /*
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = [UIColor redColor];
        statusBar.hidden = YES;
    }
     */
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarFrameChanged:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarFrameWillChange:) name:UIApplicationWillChangeStatusBarFrameNotification object:nil];
    
    [self performSelector:@selector(changeStatusBarAppearance) withObject:nil afterDelay:1.5 ];// setTimeout
     
    
}

-(void)changeStatusBarAppearance
{
    if(_hidden) _hidden = NO;
    else _hidden = YES;
    
    [[UIApplication sharedApplication] setStatusBarHidden:_hidden withAnimation:UIStatusBarAnimationSlide];
    
    
    if(_hidden)
    {
        NSLog(@"true");
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }
    else
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        NSLog(@"false");

    }
    
    [self performSelector:@selector(changeStatusBarAppearance) withObject:nil afterDelay:2.5 ]; // setTimeout
    
    [self statusBarHeight];
    
}

/*
-(void)changeStatusBarAppearance
{
    if(_hidden) _hidden = NO;
    else _hidden = YES;
    
    [UIView animateWithDuration:0.45 animations:^{
        [self setNeedsStatusBarAppearanceUpdate];
    }];
    
    [self performSelector:@selector(changeStatusBarAppearance) withObject:nil afterDelay:2.5 ]; // setTimeout
    
    float statusBarHeight = [self statusBarHeight];
    //NSLog(@"statusBarHeight = %f", statusBarHeight * 96 / 72);
    
    
}

-(BOOL)prefersStatusBarHidden
{
    return _hidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (UIStatusBarAnimation) preferredStatusBarUpdateAnimation
{
    return UIStatusBarAnimationSlide;
}
 */

-(double) statusBarHeight
{
    CGSize statusBarSize = [[UIApplication sharedApplication] statusBarFrame].size;
    
    float statusBarHeight = MIN(statusBarSize.width, statusBarSize.height);
    NSLog(@"statusBarHeight = %f", statusBarHeight * 96 / 72);
    
    
    return (double)statusBarHeight;
}

/*
- (void)statusBarFrameWillChange:(NSNotification*)notification
{
    NSValue* rectValue = [[notification userInfo] valueForKey:UIApplicationStatusBarFrameUserInfoKey];
    CGRect newFrame;
    [rectValue getValue:&newFrame];
    NSLog(@"statusBarFrameWillChange: newSize %f, %f", newFrame.size.width, newFrame.size.height);
    
}
 */

- (void)statusBarFrameChanged:(NSNotification*)notification
{
    /*
    NSValue* rectValue = [[notification userInfo] valueForKey:UIApplicationStatusBarFrameUserInfoKey];
    CGRect oldFrame;
    [rectValue getValue:&oldFrame];
    NSLog(@"statusBarFrameChanged: oldSize %f, %f", oldFrame.size.width, oldFrame.size.height);
     */
    
    [self statusBarHeight];
    
    NSLog(@"statusBarFrameChanged:");
    
    
}



@end
