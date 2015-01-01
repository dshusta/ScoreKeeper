#import "EditGameViewController.h"
#import "UIBarButtonItem+Spec.h"
#import "Game.h"
#import "Player.h"
#import "HandTableViewController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(EditGameViewControllerSpec)

describe(@"EditGameViewController", ^{
    __block UINavigationController *navigationController;
    __block EditGameViewController *editGameViewController;
    __block GameCollection *gameCollection;
    __block Game *game;
    __block NSMutableArray *players;
    
    beforeEach(^{
        players = [[NSMutableArray alloc] init];
        for(int i = 0; i < 5; i++) {
            NSString *playerName = [NSString stringWithFormat:@"Player %i", (i + 1)];
            [players addObject:[[Player alloc] initWithName:playerName]];
        }
        
        gameCollection = [[GameCollection alloc] init];
        game = [[Game alloc] initWithName:@"foo" players:players];
        editGameViewController = [[EditGameViewController alloc] initWithGameCollection:gameCollection game:game];
        navigationController = [[UINavigationController alloc] initWithRootViewController: editGameViewController];
        
        editGameViewController.view should_not be_nil;
    });
    
    it(@"should render the game's name", ^{
        editGameViewController.gameNameLabel.text should equal(@"foo");
    });
    
    it(@"should render the names of the players", ^{
        [editGameViewController.playerNameLabels[0] text] should equal(@"Player 1");
        [editGameViewController.playerNameLabels[1] text] should equal(@"Player 2");
        [editGameViewController.playerNameLabels[2] text] should equal(@"Player 3");
        [editGameViewController.playerNameLabels[3] text] should equal(@"Player 4");
        [editGameViewController.playerNameLabels[4] text] should equal(@"Player 5");
    });
    
    describe(@"tapping the 'hands' button", ^{
        beforeEach(^{
            [editGameViewController.navigationItem.rightBarButtonItem tap];
        });
        
        it(@"should navigate to HandTableViewController", ^{
            navigationController.topViewController should be_instance_of([HandTableViewController class]);
            HandTableViewController *handTableViewController = (HandTableViewController *)navigationController.topViewController;
            handTableViewController.gameCollection should equal(gameCollection);
            handTableViewController.game should equal(game);
        });
    });
});

SPEC_END
