#import "CreateScoresheetViewController.h"
#import "RootViewController.h"
#import "ScoresheetCollection.h"

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
            navController.topViewController.view should_not be_nil;
        });
        
        it(@"should display the create new scoresheet controller", ^{
            navController.topViewController should be_instance_of([CreateScoresheetViewController class]);
        });

        describe(@"after filling out a name and tapping save", ^{
            beforeEach(^{
                CreateScoresheetViewController *createController = (CreateScoresheetViewController *)navController.topViewController;
                createController.nameTextField.text = @"I am a banana";
                [createController.saveScoresheetButton sendActionsForControlEvents:UIControlEventTouchUpInside];
            });

            it(@"should create a new scoresheet", ^{
                [subject.scoresheetCollection count] should equal(1);
            });

            it(@"should navigate back to the RootViewController", ^{
                navController.topViewController should be_instance_of([RootViewController class]);
            });

            describe(@"the new scoresheet", ^{
                __block NSDictionary *scoresheet;

                beforeEach(^{
                    scoresheet = [subject.scoresheetCollection lastObject];
                });

                it(@"should save the name", ^{
                    scoresheet[@"name"] should equal(@"I am a banana");
                });
            });

            describe(@"the updated table view", ^{
                it(@"should show our scoresheet name in the list", ^{
                    RootViewController *rootViewController = (RootViewController *)navController.topViewController;
                    [rootViewController.tableView numberOfRowsInSection:0] should equal(1);
                });
            });
        });
    });
});

SPEC_END
