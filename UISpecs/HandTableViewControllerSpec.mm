#import "HandTableViewController.h"
#import "UIBarButtonItem+Spec.h"
#import "Game.h"
#import "Hand.h"
#import "EditHandViewController.h"
#import "UITableViewCell+Spec.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(HandTableViewControllerSpec)

describe(@"HandTableViewController", ^{
    __block HandTableViewController *controller;
    __block UINavigationController *navigationController;
    __block Game *game;
    __block Hand *hand1;

    UITableViewCell *(^cellAt)(NSInteger) = ^(NSInteger row) {
        return [controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
    };

    beforeEach(^{
        game = [[Game alloc] initWithName:@"Gamerz" players:@[]];
        hand1 = [[Hand alloc] init];
        Hand *hand2 = [[Hand alloc] init];
        Hand *hand3 = [[Hand alloc] init];
        game.hands = [[NSMutableArray alloc] initWithArray: @[hand1, hand2, hand3]];
        
        controller = [[HandTableViewController alloc] initWithGameCollection:NULL game:game];
        
        navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
        
        controller.view should_not be_nil;
        [controller.view layoutIfNeeded];
    });
    
    it(@"should render all hands as rows in the table", ^{
        [controller.tableView numberOfRowsInSection:0] should equal(3);
        
        cellAt(0).textLabel.text should equal(@"Hand 1");
        cellAt(1).textLabel.text should equal(@"Hand 2");
        cellAt(2).textLabel.text should equal(@"Hand 3");
        
    });
    
    it(@"should update view when new hands are added", ^{
        [game.hands addObject:[[Hand alloc] init]];
        
        [controller viewWillAppear:true];
        
        [controller.tableView numberOfRowsInSection:0] should equal(4);
        
        cellAt(0).textLabel.text should equal(@"Hand 1");
        cellAt(1).textLabel.text should equal(@"Hand 2");
        cellAt(2).textLabel.text should equal(@"Hand 3");
        cellAt(3).textLabel.text should equal(@"Hand 4");
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
            [(EditHandViewController*)navigationController.topViewController currentHand] should be_same_instance_as(hand1);
        });
    });
});

SPEC_END
