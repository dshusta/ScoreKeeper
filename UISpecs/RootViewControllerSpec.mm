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
        
        [rootViewController viewWillAppear:NO];
        [rootViewController viewDidAppear:NO];
    });
    
    describe(@"after Create New Scoresheet is tapped", ^{
        beforeEach(^{
            [rootViewController.createNewScoresheetButton sendActionsForControlEvents:UIControlEventTouchUpInside];
            [navController.topViewController view] should_not be_nil;
        });
        
        it(@"should display the create new scoresheet controller", ^{
            navController.topViewController should be_instance_of([CreateScoresheetViewController class]);
        });
        
        describe(@"tapping the save button", ^{
            beforeEach(^{
                CreateScoresheetViewController *createScoresheetViewController = (id)navController.topViewController;
                [createScoresheetViewController.saveButton sendActionsForControlEvents:UIControlEventTouchUpInside];
                

                [rootViewController viewWillAppear:NO];
                [rootViewController viewDidAppear:NO];
            });
            
            it(@"should go back to the root view controller", ^{
                navController.topViewController should be_same_instance_as(rootViewController);
            });
            
            it(@"should display the new item", ^{
                [rootViewController.scoresheetTableView numberOfRowsInSection:0] should equal(1);
            });

            describe(@"when sliding row, and tapping delete", ^{
                beforeEach(^{

                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];

                    [rootViewController.scoresheetTableView.dataSource tableView:rootViewController.scoresheetTableView
                                                              commitEditingStyle:UITableViewCellEditingStyleDelete
                                                               forRowAtIndexPath:indexPath];
                });

                it(@"should delete the scoresheet", ^{
                    [rootViewController.scoresheetTableView numberOfRowsInSection:0] should equal(0);
                });

                
            });
        });
        
    });


});

SPEC_END
