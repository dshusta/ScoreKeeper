#import "RootViewController.h"
#import "CreateScoresheetViewController.h"

@interface RootViewController ()


@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)touchUpCreateNewScoresheet:(id)sender {
    CreateScoresheetViewController* createScoresheetViewController = [[CreateScoresheetViewController alloc] init];
    [self.navigationController pushViewController:createScoresheetViewController animated:YES];
}

@end
