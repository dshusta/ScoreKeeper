#import "RootViewController.h"
#import "CreateScoresheetViewController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(RootViewControllerSpec)

describe(@"RootViewController", ^{
    __block UINavigationController *navController;
    __block RootViewController *subject;

    beforeEach(^{
        subject = [[RootViewController alloc] init];
        subject.view should_not be_nil;
        navController = [[UINavigationController alloc] initWithRootViewController:subject];
    });
    
    describe(@"after Create New Scoresheet is tapped", ^{
        beforeEach(^{
            [subject.createNewScoresheetButton sendActionsForControlEvents:UIControlEventTouchUpInside];
        });
        
        it(@"should display the create new scoresheet controller", ^{
            navController.topViewController should be_instance_of([CreateScoresheetViewController class]);
        });
    });
});

SPEC_END
