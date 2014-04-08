#import "ScoresheetViewController.h"
#import "Scoresheet.h"

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
    self.player1Label.text = self.scoresheet.player1;
    self.player2Label.text = self.scoresheet.player2;
    self.player3Label.text = self.scoresheet.player3;
    self.player4Label.text = self.scoresheet.player4;
    self.player5Label.text = self.scoresheet.player5;
}

@end
