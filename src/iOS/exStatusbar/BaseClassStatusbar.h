//
//  BaseClassStatusbar.h
//  statusbar
//
//  Created by Hadi Tavakoli on 10/26/16.
//  Copyright © 2016 MyFlashLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BaseClassStatusbar : NSObject  <UIAlertViewDelegate>
{
    BOOL okIsTouch;
}

@property (nonatomic) BOOL okIsTouch;

-(void)isTestVersion;

-(double)statusBarHeight;
-(void)hideStatusbar:(BOOL)value withAnimation:(int)animationType;
-(void)changeStatusbarStyle:(int)barStyle withAnimation:(BOOL)haveAnimation;
-(void)allowHomeIndicatorAutoHide;

-(void)dispose;

@end



