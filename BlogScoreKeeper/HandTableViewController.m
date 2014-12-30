#import "HandTableViewController.h"
#import "EditHandViewController.h"
#import "GameCollection.h"

@interface HandTableViewController ()

@property (nonatomic, strong) GameCollection *gameCollection;
@property (nonatomic, strong) Game* game;

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

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.game.hands count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                            forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Hand %li", (long)(indexPath.row + 1)];
    
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EditHandViewController *editHandViewController = [[EditHandViewController alloc] initWithGameCollection:self.gameCollection
                                                                                                       game:self.game
                                                                                                       hand:self.game.hands[indexPath.row]];
    [self.navigationController pushViewController:editHandViewController animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.game.hands removeObjectAtIndex:indexPath.row];
    [self.gameCollection synchronize];
    
    [tableView reloadData];
}

@end
