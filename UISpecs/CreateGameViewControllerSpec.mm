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

            controller.nameTextField.text = @"My Special Name";
            controller.player1TextField.text = @"Scooby Doo";
            controller.player2TextField.text = @"Shaggy";
            controller.player3TextField.text = @"Daphne";
            controller.player4TextField.text = @"Velma";
            controller.player5TextField.text = @"Fred";

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

        it(@"should pop itself off the navigation stack", ^{
            nav.topViewController should be_same_instance_as(rootViewController);
        });
    });
});

SPEC_END
