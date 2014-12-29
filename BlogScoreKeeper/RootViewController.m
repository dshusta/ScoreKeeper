#import "RootViewController.h"
#import "CreateGameViewController.h"
#import "GameCollection.h"
#import "GameViewController.h"

@interface RootViewController () <GameCollectionDelegate>

@property (strong, nonatomic) GameCollection *gameCollection;

@end


@implementation RootViewController

- (RootViewController *)init {
    self = [super init];
    if (self) {
        self.gameCollection = [[GameCollection alloc] init];
        self.gameCollection.delegate = self;
    }
    return self;
}

- (void)didTapOnGame:(Game *)game {
    GameViewController *gameViewController = [[GameViewController alloc] initWithGameCollection:self.gameCollection game:game];
    [self.navigationController pushViewController:gameViewController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"All Games";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                           target:self
                                                                                           action:@selector(touchUpCreateNewGame:)];

    self.tableView.delegate = self.gameCollection;
    self.tableView.dataSource = self.gameCollection;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)touchUpCreateNewGame:(id)sender {
    CreateGameViewController *createGameViewController = [[CreateGameViewController alloc] initWithGameCollection:self.gameCollection];
    [self.navigationController pushViewController:createGameViewController animated:YES];
}

@end
