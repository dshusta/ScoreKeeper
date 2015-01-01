#import "EditGameViewController.h"
#import "Player.h"
#import "HandTableViewController.h"

@interface EditGameViewController ()

@end

@implementation EditGameViewController

- (instancetype)init {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (instancetype)initWithGameCollection:(GameCollection *)collection game:(Game *)game {
    self = [super init];
    if (self) {
        self.game = game;
        self.gameCollection = collection;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gameNameLabel.text = self.game.name;
    [self.game.players enumerateObjectsUsingBlock:^(Player *player, NSUInteger i, BOOL *stop) {
        [self.playerNameLabels[i] setText:[player name]];
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Hands" style:UIBarButtonItemStylePlain target:self action:@selector(didTapHands:)];
}

- (void)didTapHands:(id) selector {
    HandTableViewController *handTableViewController = [[HandTableViewController alloc] initWithGameCollection:self.gameCollection game:self.game];
    [self.navigationController pushViewController:handTableViewController animated:YES];
}

@end
