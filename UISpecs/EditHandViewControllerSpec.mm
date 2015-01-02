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
    __block Player *player1;
    __block Player *player2;
    __block Player *player3;
    __block Player *player4;
    __block Player *player5;

    beforeEach(^{
        player1 = [[Player alloc] initWithName:@"player one"];
        player2 = [[Player alloc] initWithName:@"player two"];
        player3 = [[Player alloc] initWithName:@"player three"];
        player4 = [[Player alloc] initWithName:@"player four"];
        player5 = [[Player alloc] initWithName:@"player five"];
        
        NSArray *players = @[player1, player2, player3, player4, player5];
        game = [[Game alloc] initWithName:@"fooName" players:players];
        
        gameCollection = [[GameCollection alloc] init];
        [gameCollection addGame:game];
        spy_on(gameCollection);
        
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
            [editHandViewController.playerLabels[0] text] should equal(@"player one");
            [editHandViewController.playerLabels[1] text] should equal(@"player two");
            [editHandViewController.playerLabels[2] text] should equal(@"player three");
            [editHandViewController.playerLabels[3] text] should equal(@"player four");
            [editHandViewController.playerLabels[4] text] should equal(@"player five");
        });
        
        it(@"should let the user choose picker for each player", ^{
            ((UIButton*)editHandViewController.pickerButtons[0]).enabled should be_truthy;
            ((UIButton*)editHandViewController.pickerButtons[1]).enabled should be_truthy;
            ((UIButton*)editHandViewController.pickerButtons[2]).enabled should be_truthy;
            ((UIButton*)editHandViewController.pickerButtons[3]).enabled should be_truthy;
            ((UIButton*)editHandViewController.pickerButtons[4]).enabled should be_truthy;
        });
        
        it(@"should now let the user choose the partner for each player", ^{
            ((UIButton*)editHandViewController.partnerButtons[0]).enabled should be_falsy;
            ((UIButton*)editHandViewController.partnerButtons[1]).enabled should be_falsy;
            ((UIButton*)editHandViewController.partnerButtons[2]).enabled should be_falsy;
            ((UIButton*)editHandViewController.partnerButtons[3]).enabled should be_falsy;
            ((UIButton*)editHandViewController.partnerButtons[4]).enabled should be_falsy;
        });
        
        it(@"should have a disabled Save button", ^{
            editHandViewController.navigationItem.rightBarButtonItem.enabled should be_falsy;
        });
        
        describe(@"after tapping for a Picker", ^{
            beforeEach(^{
                [editHandViewController.pickerButtons[1] tap];
            });
            
            it(@"should disable all Q's", ^{
                ((UIButton*)editHandViewController.pickerButtons[0]).enabled should be_falsy;
                ((UIButton*)editHandViewController.pickerButtons[1]).enabled should be_falsy;
                ((UIButton*)editHandViewController.pickerButtons[2]).enabled should be_falsy;
                ((UIButton*)editHandViewController.pickerButtons[3]).enabled should be_falsy;
                ((UIButton*)editHandViewController.pickerButtons[4]).enabled should be_falsy;
            });
            
            it(@"should enable all J's except for Picker's", ^{
                ((UIButton*)editHandViewController.partnerButtons[0]).enabled should be_truthy;
                ((UIButton*)editHandViewController.partnerButtons[1]).enabled should be_falsy;
                ((UIButton*)editHandViewController.partnerButtons[2]).enabled should be_truthy;
                ((UIButton*)editHandViewController.partnerButtons[3]).enabled should be_truthy;
                ((UIButton*)editHandViewController.partnerButtons[4]).enabled should be_truthy;
            });
            
            it(@"should select the tapped button", ^{
                ((UIButton*)editHandViewController.pickerButtons[0]).selected should be_falsy;
                ((UIButton*)editHandViewController.pickerButtons[1]).selected should be_truthy;
                ((UIButton*)editHandViewController.pickerButtons[2]).selected should be_falsy;
                ((UIButton*)editHandViewController.pickerButtons[3]).selected should be_falsy;
                ((UIButton*)editHandViewController.pickerButtons[4]).selected should be_falsy;
            });
            
            it(@"should have a disabled Save button", ^{
                editHandViewController.navigationItem.rightBarButtonItem.enabled should be_falsy;
            });
            
            describe(@"after tapping for a Partner", ^{
                beforeEach(^{
                    [editHandViewController.partnerButtons[4] tap];
                });
                
                it(@"should disable all J's", ^{
                    ((UIButton*)editHandViewController.partnerButtons[0]).enabled should be_falsy;
                    ((UIButton*)editHandViewController.partnerButtons[1]).enabled should be_falsy;
                    ((UIButton*)editHandViewController.partnerButtons[2]).enabled should be_falsy;
                    ((UIButton*)editHandViewController.partnerButtons[3]).enabled should be_falsy;
                    ((UIButton*)editHandViewController.partnerButtons[4]).enabled should be_falsy;
                });
                
                it(@"should select the tapped button", ^{
                    ((UIButton*)editHandViewController.partnerButtons[0]).selected should be_falsy;
                    ((UIButton*)editHandViewController.partnerButtons[1]).selected should be_falsy;
                    ((UIButton*)editHandViewController.partnerButtons[2]).selected should be_falsy;
                    ((UIButton*)editHandViewController.partnerButtons[3]).selected should be_falsy;
                    ((UIButton*)editHandViewController.partnerButtons[4]).selected should be_truthy;
                });
                
                it(@"should enabled the Save button", ^{
                    editHandViewController.navigationItem.rightBarButtonItem.enabled should be_truthy;
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
                    
                    describe(@"the saved hand", ^{
                        __block Hand *handFromDb;
                        
                        beforeEach(^{
                            GameCollection *newGameCollection = [[GameCollection alloc] init];
                            Game *gameFromDb = [newGameCollection.games firstObject];
                            handFromDb = [gameFromDb.hands firstObject];
                        });
                        
                        it(@"should have the Picker preserved", ^{
                            handFromDb.pickerName should equal(player2.name);
                        });
                        
                        it(@"should have the Parnter preserved", ^{
                            handFromDb.partnerName should equal(player5.name);
                        });
                    });
                });
            });
        });
    });
    
    describe(@"for an existing Hand", ^{
        __block Hand *hand;
        
        beforeEach(^{
            hand = [[Hand alloc] initWithPickerName:@"player four" partnerName:@"player one"];
            [game.hands addObject:hand];
            
            editHandViewController = [[EditHandViewController alloc] initWithGameCollection:gameCollection game:game hand:hand];
            
            navController = [[UINavigationController alloc] initWithRootViewController:previousViewController];
            [navController pushViewController:editHandViewController animated:NO];
            
            editHandViewController.view should_not be_nil;
        });
        
        it(@"should draw a row for each player in the hand's game", ^{
            [editHandViewController.playerLabels[0] text] should equal(@"player one");
            [editHandViewController.playerLabels[1] text] should equal(@"player two");
            [editHandViewController.playerLabels[2] text] should equal(@"player three");
            [editHandViewController.playerLabels[3] text] should equal(@"player four");
            [editHandViewController.playerLabels[4] text] should equal(@"player five");
        });
        
        it(@"should disable all Q's", ^{
            ((UIButton*)editHandViewController.pickerButtons[0]).enabled should be_falsy;
            ((UIButton*)editHandViewController.pickerButtons[1]).enabled should be_falsy;
            ((UIButton*)editHandViewController.pickerButtons[2]).enabled should be_falsy;
            ((UIButton*)editHandViewController.pickerButtons[3]).enabled should be_falsy;
            ((UIButton*)editHandViewController.pickerButtons[4]).enabled should be_falsy;
        });
        
        it(@"should disable all J's", ^{
            ((UIButton*)editHandViewController.partnerButtons[0]).enabled should be_falsy;
            ((UIButton*)editHandViewController.partnerButtons[1]).enabled should be_falsy;
            ((UIButton*)editHandViewController.partnerButtons[2]).enabled should be_falsy;
            ((UIButton*)editHandViewController.partnerButtons[3]).enabled should be_falsy;
            ((UIButton*)editHandViewController.partnerButtons[4]).enabled should be_falsy;
        });
        
        it(@"should select the Picker", ^{
            ((UIButton*)editHandViewController.pickerButtons[0]).selected should be_falsy;
            ((UIButton*)editHandViewController.pickerButtons[1]).selected should be_falsy;
            ((UIButton*)editHandViewController.pickerButtons[2]).selected should be_falsy;
            ((UIButton*)editHandViewController.pickerButtons[3]).selected should be_truthy;
            ((UIButton*)editHandViewController.pickerButtons[4]).selected should be_falsy;
        });
        
        it(@"should select the Partner", ^{
            ((UIButton*)editHandViewController.partnerButtons[0]).selected should be_truthy;
            ((UIButton*)editHandViewController.partnerButtons[1]).selected should be_falsy;
            ((UIButton*)editHandViewController.partnerButtons[2]).selected should be_falsy;
            ((UIButton*)editHandViewController.partnerButtons[3]).selected should be_falsy;
            ((UIButton*)editHandViewController.partnerButtons[4]).selected should be_falsy;
        });
        
        it(@"should not have a save button", ^{
            editHandViewController.navigationItem.rightBarButtonItem should be_nil;
        });
    });
});

SPEC_END
