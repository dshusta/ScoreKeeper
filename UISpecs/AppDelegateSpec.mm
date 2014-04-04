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
        
        it(@"should display the rootViewCotroller in a navigation controller", ^{
            subject.window.rootViewController should be_instance_of([UINavigationController class]);
            UINavigationController* rootViewController = (id)subject.window.rootViewController;
            
            rootViewController.topViewController should be_instance_of([RootViewController class]);
        });
    });
});

SPEC_END
