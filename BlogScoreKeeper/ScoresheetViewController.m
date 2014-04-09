#import "ScoresheetViewController.h"
#import "Scoresheet.h"
#import "Player.h"
#import "PlayerCell.h"

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

    return cell;
}

@end
