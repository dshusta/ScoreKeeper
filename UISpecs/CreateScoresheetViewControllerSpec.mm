#import "CreateScoresheetViewController.h"
#import "ScoresheetCollection.h"
#import "Scoresheet.h"
#import "Player.h"
#import "UIKit+PivotalSpecHelper.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(CreateScoresheetViewControllerSpec)

describe(@"CreateScoresheetViewController", ^{
    __block CreateScoresheetViewController *controller;
    __block ScoresheetCollection *collection;

    beforeEach(^{
        collection = [[ScoresheetCollection alloc] init];
        controller = [[CreateScoresheetViewController alloc] initWithScoresheetCollection:collection];
        controller.view should_not be_nil;
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
        
        it(@"should save a scoresheet with the given name", ^{
            Scoresheet *scoresheet = [collection.scoresheets lastObject];
            scoresheet.name should equal(@"My Special Name");
            [scoresheet.players[0] name] should equal(@"Scooby Doo");
            [scoresheet.players[1] name] should equal(@"Shaggy");
            [scoresheet.players[2] name] should equal(@"Daphne");
            [scoresheet.players[3] name] should equal(@"Velma");
            [scoresheet.players[4] name] should equal(@"Fred");
        });



        it(@"should pop itself off the navigation stack", ^{
            nav.topViewController should be_same_instance_as(rootViewController);
        });
    });
});

SPEC_END
