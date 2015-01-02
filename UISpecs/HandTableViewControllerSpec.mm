#import "HandTableViewController.h"
#import "UIBarButtonItem+Spec.h"
#import "Game.h"
#import "Hand.h"
#import "EditHandViewController.h"
#import "UITableViewCell+Spec.h"
#import "GameCollection.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(HandTableViewControllerSpec)

describe(@"HandTableViewController", ^{
    __block UINavigationController *navigationController;
    __block HandTableViewController *controller;
    __block GameCollection *gameCollection;
    __block Game *game;
    __block Hand *hand1;
    __block Hand *hand2;
    __block Hand *hand3;

    UITableViewCell *(^cellAt)(NSInteger) = ^(NSInteger row) {
        return [controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
    };

    beforeEach(^{
        gameCollection = [[GameCollection alloc] init];
        game = [[Game alloc] initWithName:@"Gamerz" players:@[]];
        hand1 = [[Hand alloc] initWithPickerName:@"Abigail" partnerName:@"Bob"];
        hand2 = [[Hand alloc] initWithPickerName:@"Bob" partnerName:@"Clarice"];
        hand3 = [[Hand alloc] initWithPickerName:@"Clarice" partnerName:@"David"];
        game.hands = [[NSMutableArray alloc] initWithArray: @[hand1, hand2, hand3]];
        [gameCollection addGame:game];
        
        controller = [[HandTableViewController alloc] initWithGameCollection:gameCollection game:game];
        controller.view should_not be_nil;
        
        navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
        
        [controller.view layoutIfNeeded];
        [controller viewWillAppear:NO];
    });
    
    it(@"should render all hands, by recency, as rows in the table", ^{
        [controller.tableView numberOfRowsInSection:0] should equal(3);
        
        cellAt(0).textLabel.text should equal(@"Hand 3 - Clarice");
        cellAt(1).textLabel.text should equal(@"Hand 2 - Bob");
        cellAt(2).textLabel.text should equal(@"Hand 1 - Abigail");
    });
    
    it(@"should update view when new hands are added", ^{
        [game.hands addObject:[[Hand alloc] initWithPickerName:@"David" partnerName:@"Elise"]];
        
        [controller viewWillAppear:true];
        
        [controller.tableView numberOfRowsInSection:0] should equal(4);
        
        cellAt(0).textLabel.text should equal(@"Hand 4 - David");
        cellAt(1).textLabel.text should equal(@"Hand 3 - Clarice");
        cellAt(2).textLabel.text should equal(@"Hand 2 - Bob");
        cellAt(3).textLabel.text should equal(@"Hand 1 - Abigail");
    });
    
    describe(@"tapping New Hand button", ^{
        beforeEach(^{
            [controller.navigationItem.rightBarButtonItem tap];
        });
        
        it(@"should navigate to create hand", ^{
            navigationController.topViewController should be_instance_of([EditHandViewController class]);
            [(EditHandViewController*)navigationController.topViewController game] should be_same_instance_as(game);
        });
    });
    
    describe(@"tapping an existing Hand", ^{
        beforeEach(^{
            [cellAt(0) tap];
        });
        it(@"should navigate to the 'edit' hand", ^{
            navigationController.topViewController should be_instance_of([EditHandViewController class]);
            [(EditHandViewController*)navigationController.topViewController game] should be_same_instance_as(game);
            [(EditHandViewController*)navigationController.topViewController currentHand] should be_same_instance_as(hand3);
        });
    });
    
    describe(@"when sliding row and tapping delete", ^{
        beforeEach(^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            
            [controller.tableView.dataSource tableView:controller.tableView
                                    commitEditingStyle:UITableViewCellEditingStyleDelete
                                     forRowAtIndexPath:indexPath];
        });
        
        it(@"should delete the hand", ^{
            [controller.tableView numberOfRowsInSection:0] should equal(2);
            game.hands should contain(hand1);
            game.hands should contain(hand2);
            game.hands should_not contain(hand3);
            
            GameCollection *collection = [[GameCollection alloc] init];
            Game *gameFromCollection = [collection.games firstObject];
            [gameFromCollection.hands count] should equal(2);
        });
    });
});

SPEC_END
