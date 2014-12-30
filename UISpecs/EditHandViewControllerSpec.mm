#import "EditHandViewController.h"
#import "Game.h"
#import "Player.h"
#import "UIKit+PivotalSpecHelper.h"
#import "GameCollection.h"
#import "Hand.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(EditHandViewControllerSpec)

describe(@"EditHandViewController", ^{
    __block UINavigationController *navController;
    __block UIViewController *previousViewController;
    __block EditHandViewController *editHandViewController;
    
    __block GameCollection *gameCollection;
    __block Game *game;

    beforeEach(^{
        Player *player1 = [[Player alloc] initWithName:@"player one"];
        Player *player2 = [[Player alloc] initWithName:@"player two"];
        Player *player3 = [[Player alloc] initWithName:@"player three"];
        Player *player4 = [[Player alloc] initWithName:@"player four"];
        Player *player5 = [[Player alloc] initWithName:@"player five"];
        
        NSArray *players = @[player1, player2, player3, player4, player5];
        game = [[Game alloc] initWithName:@"fooName" players:players];
        
        gameCollection = nice_fake_for([GameCollection class]);
        
        previousViewController = [[UIViewController alloc] init];
    });
    
    describe(@"for a new Hand", ^{
        beforeEach(^{
            editHandViewController = [[EditHandViewController alloc] initWithGameCollection:gameCollection game:game];
            
            navController = [[UINavigationController alloc] initWithRootViewController:previousViewController];
            [navController pushViewController:editHandViewController animated:NO];
            
            editHandViewController.view should_not be_nil;
        });
        
        it(@"should draw a row for each player in the hand's game", ^{
            editHandViewController.player1Label.text should equal(@"player one");
            editHandViewController.player2Label.text should equal(@"player two");
            editHandViewController.player3Label.text should equal(@"player three");
            editHandViewController.player4Label.text should equal(@"player four");
            editHandViewController.player5Label.text should equal(@"player five");
        });
        
        describe(@"tapping Save", ^{
            beforeEach(^{
                [editHandViewController.navigationItem.rightBarButtonItem tap];
            });
            
            it(@"should return to the HandTableViewController", ^{
                navController.topViewController should be_same_instance_as(previousViewController);
            });
            
            it(@"should save a new hand to the game", ^{
                [game.hands count] should equal(1);
                gameCollection should have_received(@selector(synchronize));
            });
        });
    });
    
    describe(@"for an existing Hand", ^{
        __block Hand *hand;
        
        beforeEach(^{
            hand = [[Hand alloc] init];
            [game.hands addObject:hand];
            
            editHandViewController = [[EditHandViewController alloc] initWithGameCollection:gameCollection game:game hand:hand];
            
            navController = [[UINavigationController alloc] initWithRootViewController:previousViewController];
            [navController pushViewController:editHandViewController animated:NO];
            
            editHandViewController.view should_not be_nil;
        });
        
        it(@"should draw a row for each player in the hand's game", ^{
            editHandViewController.player1Label.text should equal(@"player one");
            editHandViewController.player2Label.text should equal(@"player two");
            editHandViewController.player3Label.text should equal(@"player three");
            editHandViewController.player4Label.text should equal(@"player four");
            editHandViewController.player5Label.text should equal(@"player five");
        });
        
        describe(@"tapping Save", ^{
            beforeEach(^{
                [editHandViewController.navigationItem.rightBarButtonItem tap];
            });
            
            it(@"should return to the HandTableViewController", ^{
                navController.topViewController should be_same_instance_as(previousViewController);
            });
            
            it(@"should update the existing hand (and not add a new one)", ^{
                [game.hands count] should equal(1);
                gameCollection should have_received(@selector(synchronize));
                game.hands should contain(hand);
            });
        });
    });
});

SPEC_END
