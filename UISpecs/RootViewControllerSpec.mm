#import "RootViewController.h"
#import "CreateGameViewController.h"
#import "GameViewController.h"
#import "Game.h"
#import "Player.h"
#import "UIKit+PivotalSpecHelper.h"

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

    describe(@"after Create New Game is tapped", ^{
        beforeEach(^{
            [rootViewController.navigationItem.rightBarButtonItem tap];
            [navController.topViewController view] should_not be_nil;
        });

        it(@"should display the create new game controller", ^{
            navController.topViewController should be_instance_of([CreateGameViewController class]);
        });

        describe(@"tapping the save button", ^{
            beforeEach(^{
                CreateGameViewController *createGameViewController = (id)navController.topViewController;
                [createGameViewController.saveButton tap];

                [rootViewController viewWillAppear:NO];
                [rootViewController viewDidAppear:NO];
            });

            it(@"should go back to the root view controller", ^{
                navController.topViewController should be_same_instance_as(rootViewController);
            });

            it(@"should display the new item", ^{
                [rootViewController.tableView numberOfRowsInSection:0] should equal(1);
            });

            describe(@"tapping on a hand", ^{
                beforeEach(^{
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                    UITableViewCell *cell = [rootViewController.tableView cellForRowAtIndexPath:indexPath];
                    [cell tap];
                });

                it(@"should display a game view controller", ^{
                    navController.topViewController should be_instance_of([GameViewController class]);
                });

                it(@"should configure the game view controller correctly", ^{
                    GameViewController *gameViewController = (id)navController.topViewController;
                    gameViewController.view should_not be_nil;
                });

                it(@"should persist total score data", ^{
                    GameViewController *gameViewController = (id)navController.topViewController;
                    gameViewController.view should_not be_nil;
                    [gameViewController.tableView layoutIfNeeded];

                    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
                    PlayerCell *cell = (PlayerCell *)[gameViewController.tableView cellForRowAtIndexPath:index];
                    cell.scoreTextField.text = @"2";

                    [cell.plusButton tap];

                    GameCollection *otherCollection = [[GameCollection alloc]init];
                    Game *game = otherCollection.games[0];
                    Player *player = game.players[0];
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

                it(@"should delete the game", ^{
                    [rootViewController.tableView numberOfRowsInSection:0] should equal(0);
                });
            });
        });
    });
});

SPEC_END
