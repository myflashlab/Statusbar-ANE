//
//  exStatusbar.m
//  exStatusbar
//
//  Created by Hadi Tavakoli on 10/26/16.
//  Copyright © 2016 MyFlashLab. All rights reserved.
//

#import "exStatusbar.h"
#import "FlashRuntimeExtensions.h"
#import "MyFlashLabsClass.h"
#import "BaseClassStatusbar.h"

@interface exStatusbar ()

typedef enum
{
    isTestVersion,
    
    getStatusbarHeight,
    hideStatusbar,
    changeStatusbarStyle,
    
    dispose,
    
    defaultEnum
} commandType;

@end

@implementation exStatusbar

FREContext freContextStatusbar;
static BaseClassStatusbar *base = nil;

commandType getEnumTitleStatusbar(NSString *theType)
{
#define CHECK_ENUM(X)   if([theType isEqualToString:@#X]) return X
    
    CHECK_ENUM(isTestVersion);
    
    CHECK_ENUM(getStatusbarHeight);
    CHECK_ENUM(hideStatusbar);
    CHECK_ENUM(changeStatusbarStyle);
    
    CHECK_ENUM(dispose);
    
    return defaultEnum;
    
#undef CHECK_ENUM
}

+ (void) dispatchEventEcode:(NSString *) ecode andElevel:(NSString *) elevel
{
    if (freContextStatusbar == NULL)
    {
        return;
    }
    
    const uint8_t* enentLevel = (const uint8_t*) [elevel UTF8String];
    const uint8_t* eventCode = (const uint8_t*) [ecode UTF8String];
    FREDispatchStatusEventAsync(freContextStatusbar, eventCode, enentLevel);
}

// -------------------------------------------------------------------------
FREObject commandStatusbar(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    FREObject retFREObject = nil;
    
    NSString *command = [MyFlashLabsClass AirToIos_String:argv[0]];
    commandType temp = getEnumTitleStatusbar(command);
    
    // save the active context from flash
    freContextStatusbar = ctx;
    
    // make sure the base class is initialized
    if (!base) base = [[BaseClassStatusbar alloc] init];
    
    
    switch (temp)
    {
        case isTestVersion:
            
            [base isTestVersion];
            
            break;
        case getStatusbarHeight:
            
            retFREObject = [MyFlashLabsClass IosToAir_Double:[base statusBarHeight]];
            
            break;
        case hideStatusbar:
            
            [base hideStatusbar:[MyFlashLabsClass AirToIos_Boolean:argv[1]]
                  withAnimation:[MyFlashLabsClass AirToIos_Integer:argv[2]]];
            
            break;
        case changeStatusbarStyle:
            
            [base changeStatusbarStyle:[MyFlashLabsClass AirToIos_Integer:argv[1]]
                         withAnimation:[MyFlashLabsClass AirToIos_Boolean:argv[2]]];
            
            break;
        case dispose:
            
            [base dispose];
            
            break;
        default:
            
            retFREObject = [MyFlashLabsClass IosToAir_String:[[MyFlashLabsClass sharedInstance] retriveCommandNotFound]];
            break;
    }
    
    // Return data back to flash
    return retFREObject;
}

void contextInitializerStatusbar(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    *numFunctionsToTest = 1;
    
    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * *numFunctionsToTest);
    
    func[0].name = (const uint8_t*) "command";
    func[0].functionData = NULL;
    func[0].function = &commandStatusbar;
    
    *functionsToSet = func;
}

void contextFinalizerStatusbar(FREContext ctx)
{
    return;
}

void comMyflashlabsStatusbarExtensionInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet)
{
    *extDataToSet = NULL;
    *ctxInitializerToSet = &contextInitializerStatusbar;
    *ctxFinalizerToSet = &contextFinalizerStatusbar;
}

void comMyflashlabsStatusbarExtensionFinalizer(void* extData)
{
    return;
}

@end
