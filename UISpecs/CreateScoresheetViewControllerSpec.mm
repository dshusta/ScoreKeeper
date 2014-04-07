#import "CreateScoresheetViewController.h"
#import "ScoresheetCollection.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(CreateScoresheetViewControllerSpec)

describe(@"CreateScoresheetViewController", ^{
    __block CreateScoresheetViewController *controller;
    __block ScoresheetCollection *collection;

    beforeEach(^{
        collection = [[ScoresheetCollection alloc] init];
        controller = [[CreateScoresheetViewController alloc] initWithScoresheetCollection:collection];
        controller.view should_not be_nil;
    });
    
    describe(@"tapping Save after entering a name", ^{
        __block UIViewController *rootViewController;
        __block UINavigationController *nav;

        beforeEach(^{
            rootViewController = [[UIViewController alloc] init];
            nav = [[UINavigationController alloc] initWithRootViewController:rootViewController];
            [nav pushViewController:controller animated:NO];

            controller.nameTextField.text = @"My Special Name";
            [controller.saveButton sendActionsForControlEvents:UIControlEventTouchUpInside];
        });
        
        it(@"should save a scoresheet with the given name", ^{
            [[collection.scoresheets lastObject] name] should equal(@"My Special Name");
        });

        it(@"should pop itself off the navigation stack", ^{
            nav.topViewController should be_same_instance_as(rootViewController);
        });
    });
});

SPEC_END
