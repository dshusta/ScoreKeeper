#import "AppDelegate.h"
#import "RootViewController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(AppDelegateSpec)

describe(@"AppDelegate", ^{
    __block AppDelegate *subject;

    beforeEach(^{
        subject = [[AppDelegate alloc] init]; //stickshift
        
    });
    
    describe(@"after the app finishes launching", ^{
        beforeEach(^{
            [subject application:nil didFinishLaunchingWithOptions:nil];
        });
        
        it(@"should set the rootViewController to our RootViewController", ^{
            subject.window.rootViewController should be_instance_of([RootViewController class]);
        });
    });
});

SPEC_END
