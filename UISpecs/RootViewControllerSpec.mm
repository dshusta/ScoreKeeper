#import "RootViewController.h"
#import "CreateScoresheetViewController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(RootViewControllerSpec)

describe(@"RootViewController", ^{
    __block UINavigationController *navController;
    __block RootViewController *rootViewController;

    beforeEach(^{
        rootViewController = [[RootViewController alloc] init];
        rootViewController.view should_not be_nil;
        navController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    });
    
    describe(@"after Create New Scoresheet is tapped", ^{
        beforeEach(^{
            [rootViewController.createNewScoresheetButton sendActionsForControlEvents:UIControlEventTouchUpInside];
            [navController.topViewController view] should_not be_nil;
        });
        
        it(@"should display the create new scoresheet controller", ^{
            navController.topViewController should be_instance_of([CreateScoresheetViewController class]);
        });
        
        describe(@"after swiping back to RootView", ^{
            beforeEach(^{
                [navController popViewControllerAnimated:NO];

                [rootViewController viewWillAppear:YES];
                [rootViewController viewDidAppear:YES];
            });
            
            it(@"should display the new item", ^{
                [rootViewController.scoresheetTableView.visibleCells count] should equal(1);
            });
        });
        
    });
});

SPEC_END
