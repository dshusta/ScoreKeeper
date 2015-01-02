#import "HandTableViewController.h"
#import "EditHandViewController.h"
#import "GameCollection.h"

@interface HandTableViewController ()

@property (nonatomic, strong) GameCollection *gameCollection;
@property (nonatomic, strong) Game* game;

- (unsigned long)indexPathRowToArrayIndex:(long)row;
@end

@implementation HandTableViewController

- (instancetype)init {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (id)initWithGameCollection:(GameCollection *)gameCollection game:(Game *)game {
    self = [super init];
    if (self) {
        self.gameCollection = gameCollection;
        self.game = game;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addHandOnTap:)];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)addHandOnTap:(id)sender {
    EditHandViewController *editHandViewController = [[EditHandViewController alloc] initWithGameCollection:self.gameCollection
                                                                                                       game:self.game];
    [self.navigationController pushViewController:editHandViewController animated:YES];
}

- (unsigned long)indexPathRowToArrayIndex:(long)row {
    unsigned long totalHands = [self.game.hands count];
    return totalHands - row - 1;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.game.hands count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                            forIndexPath:indexPath];
    
    unsigned long nthLabel = [self indexPathRowToArrayIndex:indexPath.row] + 1;
    cell.textLabel.text = [NSString stringWithFormat:@"Hand %li", (long)nthLabel];
    
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    long handsIndex = [self indexPathRowToArrayIndex:indexPath.row];
    EditHandViewController *editHandViewController = [[EditHandViewController alloc] initWithGameCollection:self.gameCollection
                                                                                                       game:self.game
                                                                                                       hand:self.game.hands[handsIndex]];
    [self.navigationController pushViewController:editHandViewController animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    long handsIndex = [self indexPathRowToArrayIndex:indexPath.row];
    [self.game.hands removeObjectAtIndex:handsIndex];
    [self.gameCollection synchronize];
    
    [tableView reloadData];
}

@end
