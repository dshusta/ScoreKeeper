#import "HandTableViewController.h"
#import "EditHandViewController.h"

@interface HandTableViewController ()

@property NSInteger handCount;

@end

@implementation HandTableViewController

- (id)initWithGame:(Game *)game {
    self = [super init];
    if (self) {
        self.handCount = [game.hands count];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addHandOnTap:)];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
    
}


- (void)addHandOnTap:(id)sender {
    EditHandViewController *editHandViewController = [[EditHandViewController alloc] initWithNibName:@"EditHandViewController" bundle:nil];
    [self.navigationController pushViewController:editHandViewController animated:YES];
    
    ++self.handCount;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.handCount - 1) inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.handCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                            forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Hand %li", indexPath.row + 1];
    
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
