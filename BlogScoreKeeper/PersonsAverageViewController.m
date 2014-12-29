#import "PersonsAverageViewController.h"
#import "GameCollection.h"

@interface PersonsAverageViewController ()

@property(nonatomic) GameCollection *gameCollection;

@end


@implementation PersonsAverageViewController

- (instancetype)initWithGameCollection:(GameCollection *)gameCollection {
    self = [super init];
    if (self) {
        self.gameCollection = gameCollection;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    //loop through games and average scores for players
}

@end
