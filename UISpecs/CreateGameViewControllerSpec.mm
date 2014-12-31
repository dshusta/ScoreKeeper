#import "CreateGameViewController.h"
#import "GameCollection.h"
#import "Game.h"
#import "Player.h"
#import "UIKit+PivotalSpecHelper.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(CreateGameViewControllerSpec)

describe(@"CreateGameViewController", ^{
    __block CreateGameViewController *controller;
    __block GameCollection *collection;

    beforeEach(^{
        spy_on([NSDate class]);
        [NSDate class] stub_method(@selector(date)).and_return([NSDate dateWithTimeIntervalSince1970:1418633994]);
        
        collection = [[GameCollection alloc] init];
        controller = [[CreateGameViewController alloc] initWithGameCollection:collection];
        controller.view should_not be_nil;
    });
    
    it(@"should prepopulate the name with the current date", ^{
        controller.nameTextField.text should equal(@"December 15, 2014");
    });
    
    describe(@"tapping Save after entering a name", ^{
        __block UIViewController *rootViewController;
        __block UINavigationController *nav;
        
        beforeEach(^{
            rootViewController = [[UIViewController alloc] init];
            nav = [[UINavigationController alloc] initWithRootViewController:rootViewController];
            [nav pushViewController:controller animated:NO];
        });
        
        it(@"should default to 'Player N' names if the user is lazy and wants to test quickly", ^{
            [controller.saveButton tap];
            Game *game = [collection.games lastObject];
            
            [game.players[0] name] should equal(@"Player 1");
            [game.players[1] name] should equal(@"Player 2");
            [game.players[2] name] should equal(@"Player 3");
            [game.players[3] name] should equal(@"Player 4");
            [game.players[4] name] should equal(@"Player 5");
        });
        
        it(@"should pop itself off the navigation stack", ^{
            [controller.saveButton tap];
            nav.topViewController should be_same_instance_as(rootViewController);
        });
        
        describe(@"when overriding default names", ^{
            beforeEach(^{
                controller.nameTextField.text = @"My Special Name";
                [controller.playerNameFields[0] setText:@"Scooby Doo"];
                [controller.playerNameFields[1] setText:@"Shaggy"];
                [controller.playerNameFields[2] setText:@"Daphne"];
                [controller.playerNameFields[3] setText:@"Velma"];
                [controller.playerNameFields[4] setText:@"Fred"];
                
                [controller.saveButton tap];
            });
            
            it(@"should save a game with the given name", ^{
                Game *game = [collection.games lastObject];
                game.name should equal(@"My Special Name");
                [game.players[0] name] should equal(@"Scooby Doo");
                [game.players[1] name] should equal(@"Shaggy");
                [game.players[2] name] should equal(@"Daphne");
                [game.players[3] name] should equal(@"Velma");
                [game.players[4] name] should equal(@"Fred");
            });
        });
    });
});

SPEC_END
