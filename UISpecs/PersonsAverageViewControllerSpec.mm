#import "PersonsAverageViewController.h"
#import "ScoresheetCollection.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(PersonsAverageViewControllerSpec)

describe(@"PersonsAverageViewController", ^{
    __block PersonsAverageViewController *subject;
    __block ScoresheetCollection *scoresheetCollection;

    beforeEach(^{
        scoresheetCollection = nice_fake_for([ScoresheetCollection class]);

        subject = [[PersonsAverageViewController alloc] initWithScoresheetCollection:scoresheetCollection];
        subject.view should_not be_nil;
    });

    it(@"should display the averages for every user", ^{
 
        [subject viewWillAppear:NO];
    });
});

SPEC_END
