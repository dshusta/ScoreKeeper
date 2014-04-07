#import "ScoresheetCollection.h"
#import "Scoresheet.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ScoresheetCollectionSpec)

describe(@"ScoresheetCollection", ^{
    __block ScoresheetCollection *subject;

    beforeEach(^{
        subject = [[ScoresheetCollection alloc] init];
    });

    describe(@"persisting scoresheets", ^{
        beforeEach(^{
            Scoresheet *scoresheet = [[Scoresheet alloc] initWithName:@"My Special Scoresheet"];
            [subject addScoresheet:scoresheet];
        });

        it(@"should persist scoresheets", ^{
            ScoresheetCollection *newCollection = [[ScoresheetCollection alloc] init];
            [newCollection count] should equal(1);
            [[newCollection.scoresheets lastObject] name] should equal(@"My Special Scoresheet");
        });

        it(@"should persist deletion of scoresheet", ^{
            NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
            [subject tableView:nil commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:path];
            ScoresheetCollection *newCollection = [[ScoresheetCollection alloc] init];
            [newCollection count] should equal(0);
        });
    });
});

SPEC_END
