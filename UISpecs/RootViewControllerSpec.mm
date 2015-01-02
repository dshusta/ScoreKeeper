#import "RootViewController.h"
#import "CreateGameViewController.h"
#import "Game.h"
#import "Player.h"
#import "PlayerFactory.h"
#import "UIKit+PivotalSpecHelper.h"
#import "HandTableViewController.h"
#import "EditGameViewController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(RootViewControllerSpec)

describe(@"RootViewController", ^{
    __block UINavigationController *navController;
    __block RootViewController *rootViewController;
    
    __block Game *game1;
    __block Game *game2;

    beforeEach(^{
        GameCollection *gameCollection = [[GameCollection alloc] init];
        game1 = [[Game alloc] initWithName:@"Game 1" players:[PlayerFactory createPlayersForGame]];
        [gameCollection addGame:game1];
        game2 = [[Game alloc] initWithName:@"Game 2" players:[PlayerFactory createPlayersForGame]];
        [gameCollection addGame:game2];
        
        rootViewController = [[RootViewController alloc] init];
        rootViewController.view should_not be_nil;

        navController = [[UINavigationController alloc] initWithRootViewController:rootViewController];

        [rootViewController viewWillAppear:NO];
    });

    it(@"should sort by recency", ^{
        UITableViewCell *topCell = [rootViewController.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        UITableViewCell *bottomCell = [rootViewController.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        
        topCell.textLabel.text should equal(@"Game 2");
        bottomCell.textLabel.text should equal(@"Game 1");
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
            });

            it(@"should go back to the root view controller", ^{
                navController.topViewController should be_same_instance_as(rootViewController);
            });

            it(@"should display the new item", ^{
                [rootViewController.tableView numberOfRowsInSection:0] should equal(3);
                [[[NSUserDefaults standardUserDefaults] objectForKey:@"games"] count] should equal(3);
            });

            describe(@"tapping on a game", ^{
                beforeEach(^{
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                    UITableViewCell *cell = [rootViewController.tableView cellForRowAtIndexPath:indexPath];
                    [cell tap];
                });

                it(@"should display a EditGameViewController", ^{
                    navController.topViewController should be_instance_of([EditGameViewController class]);
                    [(HandTableViewController*)navController.topViewController gameCollection] should be_instance_of([GameCollection class]);
                    [(HandTableViewController*)navController.topViewController game] should be_instance_of([Game class]);
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
                    [rootViewController.tableView numberOfRowsInSection:0] should equal(2);
                    [[[NSUserDefaults standardUserDefaults] objectForKey:@"games"] count] should equal(2);
                });
            });
        });
    });
});

SPEC_END
