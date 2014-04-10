#import "RootViewController.h"
#import "CreateScoresheetViewController.h"
#import "ScoresheetViewController.h"
#import "Scoresheet.h"
#import "Player.h"
#import "UIKit+PivotalSpecHelper.h"
#import "PersonsAverageViewController.h"

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

    describe(@"tapping on graph button", ^{
        beforeEach(^{
            [rootViewController.navigationItem.leftBarButtonItem tap];
        });

        it(@"should display players and their average score", ^{
            navController.topViewController should be_instance_of([PersonsAverageViewController class]);
        });
    });

    describe(@"after Create New Scoresheet is tapped", ^{
        beforeEach(^{
            [rootViewController.navigationItem.rightBarButtonItem tap];
            [navController.topViewController view] should_not be_nil;
        });

        it(@"should display the create new scoresheet controller", ^{
            navController.topViewController should be_instance_of([CreateScoresheetViewController class]);
        });

        describe(@"tapping the save button", ^{
            beforeEach(^{
                CreateScoresheetViewController *createScoresheetViewController = (id)navController.topViewController;

                createScoresheetViewController.nameTextField.text = @"My Special Scoresheet";
                [createScoresheetViewController.saveButton tap];

                [rootViewController viewWillAppear:NO];
                [rootViewController viewDidAppear:NO];
            });

            it(@"should go back to the root view controller", ^{
                navController.topViewController should be_same_instance_as(rootViewController);
            });

            it(@"should display the new item", ^{
                [rootViewController.tableView numberOfRowsInSection:0] should equal(1);
            });

            describe(@"tapping on a scoresheet", ^{
                beforeEach(^{
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                    UITableViewCell *cell = [rootViewController.tableView cellForRowAtIndexPath:indexPath];
                    [cell tap];
                });

                it(@"should display a scoresheet view controller", ^{
                    navController.topViewController should be_instance_of([ScoresheetViewController class]);
                });

                it(@"should configure the scoresheet view controller correctly", ^{
                    ScoresheetViewController *scoresheetViewController = (id)navController.topViewController;
                    scoresheetViewController.view should_not be_nil;
                    scoresheetViewController.title should equal(@"My Special Scoresheet");
                });

                it(@"should persist total score data", ^{
                    ScoresheetViewController *scoresheetViewController = (id)navController.topViewController;
                    scoresheetViewController.view should_not be_nil;
                    [scoresheetViewController.tableView layoutIfNeeded];

                    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
                    PlayerCell *cell = (PlayerCell *)[scoresheetViewController.tableView cellForRowAtIndexPath:index];
                    cell.scoreTextField.text = @"2";

                    [cell.plusButton tap];

                    ScoresheetCollection *otherCollection = [[ScoresheetCollection alloc]init];
                    Scoresheet *scoresheet = otherCollection.scoresheets[0];
                    Player *player = scoresheet.players[0];
                    player.score should equal(2);
                });
            });

            describe(@"when sliding row, and tapping delete", ^{
                beforeEach(^{
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];

                    [rootViewController.tableView.dataSource tableView:rootViewController.tableView
                                                    commitEditingStyle:UITableViewCellEditingStyleDelete
                                                     forRowAtIndexPath:indexPath];
                });

                it(@"should delete the scoresheet", ^{
                    [rootViewController.tableView numberOfRowsInSection:0] should equal(0);
                });
            });
        });
    });
});

SPEC_END
