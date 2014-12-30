#import "GameCollection.h"
#import "Game.h"
#import "Player.h"
#import "Hand.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(GameCollectionSpec)

describe(@"GameCollection", ^{
    __block GameCollection *gameCollection;

    beforeEach(^{
        gameCollection = [[GameCollection alloc] init];
    });
    
    describe(@"persisting games", ^{
        beforeEach(^{
            NSMutableArray *players = [[NSMutableArray alloc] init];
            [players addObject:[[Player alloc] initWithName:@"Scooby Dooby DOO"]];
            [players addObject:[[Player alloc] initWithName:@"Daphne"]];
            [players addObject:[[Player alloc] initWithName:@"Velma"]];
            [players addObject:[[Player alloc] initWithName:@"Fred"]];
            [players addObject:[[Player alloc] initWithName:@"Shaggy"]];

            Game *game = [[Game alloc] initWithName:@"My Special Game" players:players];
            [game.hands addObject:[[Hand alloc] init]];
            [gameCollection addGame:game];
        });

        it(@"should persist games", ^{
            GameCollection *newCollection = [[GameCollection alloc] init];
            [newCollection.games count] should equal(1);
            [[newCollection.games lastObject] name] should equal(@"My Special Game");
        });

        it(@"should persist deletion of game", ^{
            Game *game = [[gameCollection games] firstObject];
            [gameCollection removeGame:game];
            
            GameCollection *newCollection = [[GameCollection alloc] init];
            [newCollection.games count] should equal(0);
        });

        it(@"should persist players", ^{
            GameCollection *newCollection = [[GameCollection alloc] init];
            Game *game = [newCollection.games lastObject];

            [game.players[0] name] should equal(@"Scooby Dooby DOO");
            [game.players[1] name] should equal(@"Daphne");
            [game.players[2] name] should equal(@"Velma");
            [game.players[3] name] should equal(@"Fred");
            [game.players[4] name] should equal(@"Shaggy");
        });
        
        it(@"should persist hands", ^{
            GameCollection *newCollection = [[GameCollection alloc] init];
            Game *game = [newCollection.games lastObject];
            
            [game.hands count] should equal(1);
            game.hands[0] should be_instance_of([Hand class]);
        });
    });
});

SPEC_END
