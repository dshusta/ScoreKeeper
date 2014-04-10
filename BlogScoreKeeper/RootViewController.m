#import "RootViewController.h"
#import "CreateScoresheetViewController.h"
#import "ScoresheetCollection.h"
#import "ScoresheetViewController.h"

@interface RootViewController () <ScoresheetCollectionDelegate>

@property (strong, nonatomic) ScoresheetCollection *scoresheetCollection;

@end


@implementation RootViewController

- (RootViewController *)init {
    self = [super init];
    if (self) {
        self.scoresheetCollection = [[ScoresheetCollection alloc] init];
        self.scoresheetCollection.delegate = self;
    }
    return self;
}

- (void)didTapOnScoresheet:(Scoresheet *)scoresheet {
    ScoresheetViewController *scoresheetViewController = [[ScoresheetViewController alloc] initWithScoreSheetCollection:self.scoresheetCollection scoresheet:scoresheet];
    [self.navigationController pushViewController:scoresheetViewController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"All Scoresheets";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                           target:self
                                                                                           action:@selector(touchUpCreateNewScoresheet:)];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"glyphicons_041_charts"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:nil];

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
