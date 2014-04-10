#import "PersonsAverageViewController.h"
#import "ScoresheetCollection.h"

@interface PersonsAverageViewController ()

@property(nonatomic) ScoresheetCollection* scoresheetCollection;

@end


@implementation PersonsAverageViewController

- (instancetype)initWithScoresheetCollection:(ScoresheetCollection *)scoresheetCollection {
    self = [super init];
    if (self) {
        self.scoresheetCollection = scoresheetCollection;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    //loop through scoresheets and average scores for players
}

@end
