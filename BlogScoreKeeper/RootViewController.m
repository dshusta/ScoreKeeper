#import "RootViewController.h"
#import "CreateGameViewController.h"
#import "GameCollection.h"
#import "HandTableViewController.h"

@interface RootViewController ()

@property (strong, nonatomic) GameCollection *gameCollection;

@end


@implementation RootViewController

- (RootViewController *)init {
    self = [super init];
    if (self) {
        self.gameCollection = [[GameCollection alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"All Games";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                           target:self
                                                                                           action:@selector(touchUpCreateNewGame:)];
}

- (void)touchUpCreateNewGame:(id)sender {
    CreateGameViewController *createGameViewController = [[CreateGameViewController alloc] initWithGameCollection:self.gameCollection];
    [self.navigationController pushViewController:createGameViewController animated:YES];
}

#pragma TableView callbacks

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.gameCollection.games count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = NSStringFromClass([self class]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    NSString *gameName = [[self.gameCollection.games objectAtIndex:indexPath.row] name];
    [cell.textLabel setText:gameName];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HandTableViewController *handTableViewController = [[HandTableViewController alloc] init];
    [self.navigationController pushViewController:handTableViewController animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.gameCollection removeGame:self.gameCollection.games[indexPath.row]];
    [tableView reloadData];
}

@end
