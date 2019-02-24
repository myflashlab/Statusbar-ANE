#import <UIKit/UIKit.h>

#define ALSO_OVERRIDE_CLASS_METHOD 1

@interface NSObject (MHOverride)

-(BOOL)mh_overrideSelector:(SEL)selector withBlock:(void *)block;
-(void *)mh_superForSelector:(SEL)selector;

@end
