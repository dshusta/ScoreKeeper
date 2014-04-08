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
    ScoresheetViewController *scoresheetViewController = [[ScoresheetViewController alloc] initWithScoresheet:scoresheet];
    [self.navigationController pushViewController:scoresheetViewController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.scoresheetTableView.delegate = self.scoresheetCollection;
    self.scoresheetTableView.dataSource = self.scoresheetCollection;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.scoresheetTableView reloadData];
}

- (IBAction)touchUpCreateNewScoresheet:(id)sender {
    CreateScoresheetViewController* createScoresheetViewController = [[CreateScoresheetViewController alloc] initWithScoresheetCollection:self.scoresheetCollection];
    [self.navigationController pushViewController:createScoresheetViewController animated:YES];
}

@end
