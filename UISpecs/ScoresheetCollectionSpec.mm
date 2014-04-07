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
            scoresheet.player1 = @"Scooby Dooby DOO";
            scoresheet.player2 = @"Daphne";
            scoresheet.player3 = @"Velma";
            scoresheet.player4 = @"Fred";
            scoresheet.player5 = @"Shaggy";

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

        it(@"should persist players", ^{
            ScoresheetCollection *newCollection = [[ScoresheetCollection alloc] init];
            [[newCollection.scoresheets lastObject] player1] should equal(@"Scooby Dooby DOO");
            [[newCollection.scoresheets lastObject] player2] should equal(@"Daphne");
            [[newCollection.scoresheets lastObject] player3] should equal(@"Velma");
            [[newCollection.scoresheets lastObject] player5] should equal(@"Shaggy");
            [[newCollection.scoresheets lastObject] player4] should equal(@"Fred");
        });
    });
});

SPEC_END
