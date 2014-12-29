#import "GameViewController.h"
#import "Game.h"
#import "Player.h"
#import "GameCollection.h"

@interface GameViewController ()

@property (nonatomic) Game *game;
@property (nonatomic) GameCollection *gameCollection;

@end


@implementation GameViewController

- (instancetype)initWithGameCollection:(GameCollection *)gameCollection game:(Game *)game {
    self = [super init];
    if (self) {
        self.game = game;
        self.gameCollection = gameCollection;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = self.game.name;
    self.tableView.rowHeight = 88.0f;

    UINib *playerCellNib = [UINib nibWithNibName:@"PlayerCell" bundle:nil];
    [self.tableView registerNib:playerCellNib forCellReuseIdentifier:@"PlayerCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.game.players count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayerCell"];

    Player *player = self.game.players[indexPath.row];
    cell.playerNameLabel.text = player.name;
    cell.totalScoreLabel.text = [NSString stringWithFormat:@"%ld", (long)player.score];

    cell.delegate = self;
    cell.index = indexPath.row;

    return cell;
}

- (void)playerCellDidTapPlusButton:(PlayerCell *)playerCell {
    NSInteger diff = [playerCell.scoreTextField.text integerValue];

    Player *player = self.game.players[playerCell.index];
    player.score += diff;
    [self.gameCollection saveToUserDefaults];
    [self.tableView reloadData];
}

- (void)playerCellDidTapMinusButton:(PlayerCell *)playerCell {
    NSInteger diff = [playerCell.scoreTextField.text integerValue];

    Player *player = self.game.players[playerCell.index];
    player.score -= diff;
    [self.gameCollection saveToUserDefaults];
    [self.tableView reloadData];
}

@end
