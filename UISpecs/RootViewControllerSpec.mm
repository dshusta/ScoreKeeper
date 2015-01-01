#import "RootViewController.h"
#import "CreateGameViewController.h"
#import "Game.h"
#import "Player.h"
#import "UIKit+PivotalSpecHelper.h"
#import "HandTableViewController.h"
#import "EditGameViewController.h"
#import "PlayerFactory.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(RootViewControllerSpec)

describe(@"RootViewController", ^{
    __block UINavigationController *navController;
    __block RootViewController *rootViewController;
    
    __block Game *game1;
    __block Game *game2;
    
    __block NSDate *now;
    
    Game *(^createGameWithNameAtTime)(NSString *, double time) = ^(NSString *name, double time) {
        [NSDate class] stub_method(@selector(date)).and_return([NSDate dateWithTimeIntervalSince1970:time]);
        Game *game = [[Game alloc] initWithName:name players:[PlayerFactory createPlayersForGame]];
        
        GameCollection *gameCollection = [[GameCollection alloc] init];
        [gameCollection addGame: game];
        [gameCollection synchronize];
        [[NSDate class] reset];
        
        return game;
    };

    beforeEach(^{
        now = [NSDate date];
        spy_on([NSDate class]);
        
        game1 = createGameWithNameAtTime(@"First created", [now timeIntervalSince1970] - 40000.0);
        game2 = createGameWithNameAtTime(@"Second created", [now timeIntervalSince1970] - 20000.0);
        
        rootViewController = [[RootViewController alloc] init];
        rootViewController.view should_not be_nil;

        navController = [[UINavigationController alloc] initWithRootViewController:rootViewController];

        [rootViewController viewWillAppear:NO];
    });
    
    it(@"should sort games by recency", ^{
        [rootViewController.tableView numberOfRowsInSection:0] should equal(2);
        
        UITableViewCell *cell = [rootViewController.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        cell.textLabel.text should equal(game2.name);
        
        cell = [rootViewController.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        cell.textLabel.text should equal(game1.name);
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
                [rootViewController.tableView numberOfRowsInSection:0] should equal(1);
                [[[NSUserDefaults standardUserDefaults] objectForKey:@"games"] count] should equal(1);
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
                    [rootViewController.tableView numberOfRowsInSection:0] should equal(0);
                    [[[NSUserDefaults standardUserDefaults] objectForKey:@"games"] count] should equal(0);
                });
            });
        });
    });
});

SPEC_END
