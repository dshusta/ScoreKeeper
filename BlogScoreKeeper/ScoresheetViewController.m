#import "ScoresheetViewController.h"
#import "Scoresheet.h"
#import "Player.h"

@interface ScoresheetViewController ()

@property (nonatomic) Scoresheet *scoresheet;

@end


@implementation ScoresheetViewController

- (id)initWithScoresheet:(Scoresheet *)scoresheet {
    self = [super init];
    if (self) {
        self.scoresheet = scoresheet;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = self.scoresheet.name;

    UINib *playerCellNib = [UINib nibWithNibName:@"PlayerCell" bundle:nil];
    [self.tableView registerNib:playerCellNib forCellReuseIdentifier:@"PlayerCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.scoresheet.players count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayerCell"];

    Player *player = self.scoresheet.players[indexPath.row];
    cell.playerNameLabel.text = player.name;
    cell.totalScoreLabel.text = [NSString stringWithFormat:@"%ld", (long)player.score];

    cell.delegate = self;
    cell.index = indexPath.row;

    return cell;
}

- (void)playerCellDidTapPlusButton:(PlayerCell *)playerCell {
    NSInteger diff = [playerCell.scoreTextField.text integerValue];

    Player *player = self.scoresheet.players[playerCell.index];
    player.score += diff;

    [self.tableView reloadData];
}

- (void)playerCellDidTapMinusButton:(PlayerCell *)playerCell {
    NSInteger diff = [playerCell.scoreTextField.text integerValue];

    Player *player = self.scoresheet.players[playerCell.index];
    player.score -= diff;

    [self.tableView reloadData];
}

@end
