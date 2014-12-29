#import "PersonsAverageViewController.h"
#import "GameCollection.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(PersonsAverageViewControllerSpec)

describe(@"PersonsAverageViewController", ^{
    __block PersonsAverageViewController *subject;
    __block GameCollection *gameCollection;

    beforeEach(^{
        gameCollection = nice_fake_for([GameCollection class]);

        subject = [[PersonsAverageViewController alloc] initWithGameCollection:gameCollection];
        subject.view should_not be_nil;
    });

    xit(@"should display the averages for every user", ^{
 
        [subject viewWillAppear:NO];
    });
});

SPEC_END
