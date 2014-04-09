#import "ScoresheetCollection.h"
#import "Scoresheet.h"
#import "Player.h"

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

            NSMutableArray *players = [[NSMutableArray alloc] init];
            [players addObject:[[Player alloc] initWithName:@"Scooby Dooby DOO"]];
            [players addObject:[[Player alloc] initWithName:@"Daphne"]];
            [players addObject:[[Player alloc] initWithName:@"Velma"]];
            [players addObject:[[Player alloc] initWithName:@"Fred"]];
            [players addObject:[[Player alloc] initWithName:@"Shaggy"]];


            Scoresheet *scoresheet = [[Scoresheet alloc] initWithName:@"My Special Scoresheet" players:players];
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
            Scoresheet *scoresheet = [newCollection.scoresheets lastObject];

            [scoresheet.players[0] name] should equal(@"Scooby Dooby DOO");
            [scoresheet.players[1] name] should equal(@"Daphne");
            [scoresheet.players[2] name] should equal(@"Velma");
            [scoresheet.players[3] name] should equal(@"Fred");
            [scoresheet.players[4] name] should equal(@"Shaggy");
        });
    });
});

SPEC_END
