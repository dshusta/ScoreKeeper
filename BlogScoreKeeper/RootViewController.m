#import "RootViewController.h"
#import "CreateScoresheetViewController.h"
#import "ScoresheetCollection.h"

@implementation RootViewController

- (id)init {
    self = [super init];
    if (self) {
        self.scoresheetCollection = [[ScoresheetCollection alloc] init];
    }
    return self; 
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Scoresheets";
    self.createNewScoresheetButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.createNewScoresheetButton addTarget:self action:@selector(touchUpCreateNewScoresheet:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:self.createNewScoresheetButton];

    self.tableView.delegate = self.scoresheetCollection;
    self.tableView.dataSource = self.scoresheetCollection;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)touchUpCreateNewScoresheet:(id)sender {
    CreateScoresheetViewController* createScoresheetViewController = [[CreateScoresheetViewController alloc] initWithScoresheetCollection:self.scoresheetCollection];
    [self.navigationController pushViewController:createScoresheetViewController animated:YES];
}

@end
