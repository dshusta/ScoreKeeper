#import "RootViewController.h"
#import "CreateScoresheetViewController.h"
#import "ScoresheetCollection.h"

@interface RootViewController ()

@property (strong, nonatomic) ScoresheetCollection *scoresheetCollection;

@end

@implementation RootViewController

- (RootViewController *)init {
    self = [super init];
    if (self) {
        self.scoresheetCollection = [[ScoresheetCollection alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
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
